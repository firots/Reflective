//
//  StartButton.swift
//  LasersAndMirrors
//
//  Created by Firot on 6.05.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import UIKit
import SpriteKit

class StartButton: SKNode {
    let logo: SKSpriteNode!

    override init() {
        logo = SKSpriteNode(imageNamed: "right")
        logo.zPosition = 1
        logo.position = CGPoint(x:0, y:0)
        super.init()
        self.name = "startGame"
        logo.startBeating()
        addChild(logo)
        setScale(GameScene.scale)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
