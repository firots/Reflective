//
//  Laser.swift
//  LasersAndMirrors
//
//  Created by Firot on 22.04.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import UIKit
import SpriteKit

class Laser: SKNode {
    var base: SKShapeNode!
    var isLaser: Bool!
    static let color = Colors.red
    static let width: CGFloat = 1
    static let glowWidth: CGFloat = 2
    static let guideWidth: CGFloat = 1
    static let shader = SKShader(fileNamed: "rainbow")
    static var bounced = 0

    override init() {
        super.init()
    }
    
    func start(from startPoint: CGPoint, angle: CGFloat, distance: CGFloat, color: SKColor, width: CGFloat, glowWidth: CGFloat, isLaser: Bool, shader: SKShader? ) {
        self.base = SKShapeNode()
        self.isLaser = isLaser
        base.lineWidth = width * GameScene.scale
        base.glowWidth = glowWidth * GameScene.scale
        base.zPosition = 100
        
        if self.isLaser == true {
            //base.strokeShader = Laser.shader
            base.strokeColor = color
            let fade: SKAction = SKAction.fadeOut(withDuration: 0.7)
            fade.timingMode = .easeIn
            let remove: SKAction = SKAction.run {
                if let scene = self.scene as? GameScene {
                    scene.lasers.removeAll()
                    for mirror in scene.mirrors {
                        mirror.glow(false)
                    }
                }
                self.removeFromParent()
            }
            base.run(SKAction.sequence ( [fade, remove]))
        } else {
            base.strokeColor = color
        }
        addChild(base)
        let _ = isTargetVisibleAtAngle(startPoint: startPoint, angle: angle + (CGFloat.pi / 2), distance: distance, color: color)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isTargetVisibleAtAngle(startPoint: CGPoint, angle: CGFloat, distance: CGFloat, color: SKColor) -> Bool {
        guard let scene = scene as? GameScene else { return false }
        let rayStart = startPoint
        let rayEnd = CGPoint(x: rayStart.x + distance * cos(angle),
                             y: rayStart.y + distance * sin(angle))
        
        let path = CGMutablePath()
        path.move(to: rayStart)
        path.addLine(to: rayEnd)
        self.base.path = path
        
       var foundOne = false
        let _ = scene.physicsWorld.enumerateBodies(alongRayStart: rayStart, end: rayEnd) { (body, point, vector, stop) in
            if !foundOne {
                foundOne = true
                let p = CGMutablePath()
                p.move(to: rayStart)
                p.addLine(to: point)
                self.base.path = p
                if self.isLaser {
                    if let obj = body.node {
                        if obj.name == "reflector" {
                            if let mirror = obj.parent as? Mirror {
                                if (color == mirror.color || self.base.strokeShader != nil) {
                                    mirror.glow(true)
                                    let refAngle: CGFloat
                                    var bounceAngle: CGFloat
                                    if mirror.zRotation == 0 {
                                        refAngle = angle + .pi / 2
                                        bounceAngle = -refAngle + .pi
                                    } else {
                                        refAngle = angle + .pi / 2
                                        bounceAngle = -refAngle
                                    }
                                    self.bounce(from: point, angle: bounceAngle, color: color.change(scene: scene))
                                }
                            }
                            return
                        } else if (obj.name == "ball") {
                            if let ball = obj.parent as? Ball {
                                if (ball.color == color || self.base.strokeShader != nil) {
                                    ball.hit()
                                        scene.wonLevel()
                                }
                            }
                        }
                    }
                }

            }
        }
        return false
    }
    
    func bounce(from startPoint: CGPoint, angle: CGFloat, color: SKColor) {
        Laser.bounced += 1
        if (Laser.bounced > 50) {
            Laser.bounced = 0
            return
        }
        guard let scene = scene as? GameScene else { return }
        let laser = Laser()
        scene.lasers.append(laser)
        var shader: SKShader? = nil
        if self.base.strokeShader != nil {
            shader = self.base.strokeShader
        }
        scene.addChild(laser)
        laser.start(from: startPoint, angle: angle, distance: scene.size.height * 2, color: color, width: Laser.width, glowWidth: Laser.glowWidth, isLaser: true, shader: shader)
    }
}
