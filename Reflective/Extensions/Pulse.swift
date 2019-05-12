//
//  SKSpriteNode.swift
//  Reflective
//
//  Created by Firot on 12.05.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import Foundation
import SpriteKit

extension SKSpriteNode {
    func startBeating() {
        let pulseUp = SKAction.scale(to: 1.4, duration: 1.5)
        let pulseDown = SKAction.scale(to: 1, duration: 1.5)
        let pulse = SKAction.sequence([pulseUp, pulseDown])
        let repeatPulse = SKAction.repeatForever(pulse)
        self.run(repeatPulse)
    }
}

extension SKLabelNode {
    func startBeating() {
        let pulseUp = SKAction.scale(to: 1.4, duration: 1.5)
        let pulseDown = SKAction.scale(to: 1, duration: 1.5)
        let pulse = SKAction.sequence([pulseUp, pulseDown])
        let repeatPulse = SKAction.repeatForever(pulse)
        self.run(repeatPulse)
    }
}
