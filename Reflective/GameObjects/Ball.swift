//
//  Ball.swift
//  LasersAndMirrors
//
//  Created by Firot on 23.04.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import UIKit
import SpriteKit

class Ball: SKNode {
    
    var base: SKSpriteNode!
    var light: SKLightNode?
    var color = Colors.red {
        didSet {
            base.color = color
            if let light = self.light {
                 light.lightColor = color
            }
        }
    }
    
    override init() {
        super.init()
        self.name = "ball"
        base = SKSpriteNode(imageNamed: "ball")
        base.color = color
        base.colorBlendFactor = 1.0
        base.physicsBody = SKPhysicsBody(circleOfRadius: base.size.width / 2.0)
        base.physicsBody?.isDynamic = false
        base.name = "ball"
        base.position = CGPoint(x: 0, y: 0)
        base.zPosition = 1
        addChild(base)
        
        if Settings.shadows == true {
            light = SKLightNode()
            light!.position = CGPoint(x: 0 / 2, y: 0)
            light!.categoryBitMask = 0b0001
            light!.lightColor = self.color
            light!.falloff = 0.2
            addChild(light!)
        }
        setScale(GameScene.scale * 0.2)
    }
    
    
    func hit() {
        burnOut()
        base.shader = Laser.shader
    }
    
    func burnOut() {
        if let light = self.light {
            light.isHidden = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}



