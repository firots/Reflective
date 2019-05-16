//
//  Cannon.swift
//  LasersAndMirrors
//
//  Created by Firot on 14.04.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import UIKit
import SpriteKit

class Cannon: SKNode {
    
    static var size: CGSize!
    var foundation: SKSpriteNode
    var light: SKLightNode?
    var barrel: SKSpriteNode
    var charge = false
    var dragging = -1
    var rotating: CGPoint!
    var rotatingTime: TimeInterval!
    var color = Colors.red {
        didSet {
            foundation.color = color
            barrel.color = color
            if let light = self.light {
                light.lightColor = color
            }
        }
    }
    
    override init() {
        foundation = SKSpriteNode(texture: nil, color: color, size: CGSize(width: 40, height: 40))
        foundation.physicsBody = SKPhysicsBody(rectangleOf: foundation.size)
        foundation.physicsBody?.isDynamic = false
        foundation.name = "foundation"
        foundation.position = CGPoint(x: 0, y: 0)
        foundation.zPosition = 100

        barrel = SKSpriteNode(texture: nil, color: color, size: CGSize(width: 10, height: 40))
        barrel.physicsBody = SKPhysicsBody(rectangleOf: barrel.size)
        barrel.physicsBody?.isDynamic = false
        barrel.name = "foundation"
        barrel.position = CGPoint(x: 0, y: 20)
        barrel.zPosition = 100
        
        super.init()
        self.name = "cannon"
        addChild(barrel)
        addChild(foundation)
        
        if Settings.shadows == true {
            light = SKLightNode()
            light!.position = CGPoint(x: 0 / 2, y: 0)
            light!.categoryBitMask = 2
            light!.falloff = 2
            addChild(light!)
        }
        setScale(GameScene.scale)
    }
    
    func fire() {
        charge = false
        Laser.bounced = 0
        guard let scene = scene as? GameScene else { return }
        let startPoint = CGPoint(x: position.x + barrel.position.x, y: position.y + barrel.position.y)
        clearLasersAndGuides()
        let laser = Laser()
        scene.lasers.append(laser)
        scene.addChild(laser)
        Sound.play("piyu", scene: scene)
        laser.start(from: startPoint, angle: barrel.zRotation, distance: scene.size.width * 1.4, color: self.color, width: Laser.width, glowWidth: Laser.glowWidth, isLaser: true, shader: nil)
    }
    
    func clearLasersAndGuides() {
        guard let scene = scene as? GameScene else { return }
        if let guide = scene.guide {
            guide.removeFromParent()
            scene.guide = nil
        }
        for laser in scene.lasers {
            laser.removeFromParent()
        }
        scene.lasers.removeAll()
    }
    
    func isShooting() -> Bool {
        guard let scene = scene as? GameScene else { return false }
        return !scene.lasers.isEmpty
    }
    
    func drawGuide() {
        guard let scene = scene as? GameScene else { return }
        clearLasersAndGuides()
        scene.guide = Laser()
        scene.addChild(scene.guide!)
        let startPoint = CGPoint(x: position.x + barrel.position.x, y: position.y + barrel.position.y)
        scene.guide!.start(from: startPoint, angle: barrel.zRotation, distance: scene.size.width * 1.4, color: .white, width: Laser.guideWidth, glowWidth: Laser.guideWidth, isLaser: false, shader: nil)
    }
    
    func rotate(to touchPosition:CGPoint, at time: TimeInterval) {
        let distance =  rotating.x - touchPosition.x
        let rotation = (barrel.zRotation + distance / 300)
        if (rotation < .pi / 2 && rotation > -1.56 ) {
            barrel.zRotation = rotation
            
        }
        drawGuide()
        rotating = touchPosition
    }
    

    
    func stopRotating() {
        guard let scene = scene as? GameScene else { return }
        rotating = nil
        rotatingTime = nil
        if let guide = scene.guide {
            guide.removeFromParent()
            scene.guide = nil
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
