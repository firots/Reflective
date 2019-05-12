//
//  Mirror.swift
//  LasersAndMirrors
//
//  Created by Firot on 14.04.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import UIKit
import SpriteKit

class Mirror: SKNode {
    public static var size: CGSize!
    public static var spawnPos: CGPoint!
    
    var mirrorBase: SKSpriteNode
    var mirrorTop: SKSpriteNode
    var mirrorBottom: SKSpriteNode
    var reflector: SKSpriteNode
    var snappedPos: CGPoint?
    var light: SKLightNode?
    var reversed = false
    let cubeSize = 50
    var color: SKColor! {
        didSet {
            reflector.color = self.color
            if let light = self.light {
                light.lightColor = self.color
            }
        }
    }

    override var position: CGPoint {
        didSet {
            setDirection()
        }
    }
    
    override  init() {
        mirrorBase = SKSpriteNode(texture: nil, color: UIColor.lightGray, size: CGSize(width: cubeSize * 2, height: cubeSize))
        mirrorBase.name = "mirrorBase"
        mirrorBase.position = CGPoint(x: 0, y: 0)
        mirrorBase.zPosition = 1
        mirrorBase.isHidden = true
        
        mirrorTop = SKSpriteNode(texture: nil, color: UIColor.darkGray, size: CGSize(width: 10, height: 5))
        mirrorTop.name = "mirrorTop"
        mirrorTop.position = CGPoint(x: 0, y: CGFloat(cubeSize) / 2 + 2.5)
        mirrorTop.zPosition = 1
        mirrorTop.physicsBody = SKPhysicsBody(rectangleOf: mirrorTop.size)
        mirrorTop.physicsBody?.isDynamic = false
        
        mirrorBottom = SKSpriteNode(texture: nil, color: UIColor.darkGray, size: CGSize(width: 10, height: 5))
        mirrorBottom.name = "mirrorBottom"
        
        mirrorBottom.position = CGPoint(x: 0, y: ((CGFloat(cubeSize) / 2) + 2.5) * -1)
        mirrorBottom.zPosition = 1
        mirrorBottom.physicsBody = SKPhysicsBody(rectangleOf: mirrorBottom.size)
        mirrorBottom.physicsBody?.isDynamic = false
        
        reflector = SKSpriteNode(texture: nil, color: Colors.red, size: CGSize(width: 10, height: cubeSize))
        reflector.physicsBody = SKPhysicsBody(rectangleOf: reflector.size)
        reflector.colorBlendFactor = 1
        reflector.physicsBody?.isDynamic = false
        reflector.position = CGPoint(x: 0, y: 0)
        reflector.zPosition = 1
        reflector.name = "reflector"
        
        super.init()
        self.name = "mirror"
        addChild(mirrorBase)
        addChild(mirrorTop)
        addChild(reflector)
        addChild(mirrorBottom)

        if Settings.shadows == true {
            light = SKLightNode()
            light!.position = CGPoint(x: 0 / 2, y: 0)
            light!.categoryBitMask = 2
            light!.falloff = 0.75
            addChild(light!)
        }
        setScale(GameScene.scale)
    }
    
    func setDirection() {
        guard let scene = scene as? GameScene else { return }
        if let snapper = nearestSnapper(scene: scene) {
            if snapper.direction == SnapDirection.top || snapper.direction == SnapDirection.bottom {
                zRotation = .pi / 2
            } else {
                zRotation = 0
            }
            return
        } else {
            zRotation = 0
        }
    }
    
    func nearestSnapper(scene: GameScene) -> Snapper? {
        var minDistance: CGFloat = reflector.size.width * 2
        var closestSnapper: Snapper?
        for blocker in scene.blocks {
            for snapper in blocker.snappers {
                let distance = self.position.distance(point: snapper.parent!.convert(snapper.position, to: scene))
                if distance < minDistance {
                    minDistance = distance
                    closestSnapper = snapper
                }
            }
        }
        return closestSnapper
    }
    
    func glow(_ state: Bool) {
        if state == true {
            reflector.shader = Laser.shader
        } else {
            reflector.shader = nil
        }
    }
    
    func beginSnap(test: Bool = false, at position: CGPoint) -> Bool {
        if let scene = scene as? GameScene {
            var position = position
            if let snapper = nearestSnapper(scene: scene) {
                if (test == false) {
                    position = snapper.parent!.convert(snapper.position, to: scene)
                    findSnapper(at: position, scene)
                }
                return true
            }
            else {
                if position.y > scene.size.width * 1.65 {position.y = scene.size.width * 1.65 }
                else if position.y < Mirror.size.height * 1.5  { position.y = Mirror.size.height * 1.5   }
                if (position.x + Mirror.size.width / 2 > scene.size.width) {
                    if (test == false) {
                        findSnapPos(at: CGPoint(x: scene.size.width - reflector.size.width / 2,  y: position.y), scene)
                    }
                    return true
                } else if (position.x < Mirror.size.width / 2) {
                    if (test == false) {
                        findSnapPos(at: CGPoint(x: reflector.size.width / 2, y: position.y), scene)
                    }
                    return true
                }
            }
            if test == false {
                scene.resetDraggingMirror()
            }
        }
        return false
    }
    
    func findSnapper(at position: CGPoint?, _ scene: GameScene) {
        var position = position
        for mirror in scene.mirrors {
            if mirror.position == position {
                position = nil
                break
            }
        }
        snap(at: position, scene)
    }
    
    func findSnapPos(at position: CGPoint, _ scene: GameScene) {
        var snapPoint: CGPoint? = position
        if let mirror = scene.mirrorAt(position, mirror: self) {
            snapPoint = nil
            if position.y > mirror.position.y {
                let topPoint = CGPoint(x: mirror.position.x, y: mirror.position.y + Mirror.size.height)
                if scene.mirrorAt(topPoint, mirror: self) == nil && beginSnap(test: true, at: topPoint) {
                    snapPoint = topPoint
                }
            } else {
                let bottomPoint = CGPoint(x: mirror.position.x, y: mirror.position.y - Mirror.size.height)
                if scene.mirrorAt(bottomPoint, mirror: self) == nil && beginSnap(test: true, at: bottomPoint) {
                    snapPoint = bottomPoint
                }
            }
        }
        self.snap(at: snapPoint, scene)
    }
    
    func snap(at position: CGPoint?, _ scene: GameScene) {
        guard let snapPoint = position else {
            scene.resetDraggingMirror()
            return
        }
        self.position = snapPoint
        if snappedPos == nil {
            scene.remeaningMirrors -= 1
        }
        snappedPos = snapPoint
        scene.draggingMirror = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
