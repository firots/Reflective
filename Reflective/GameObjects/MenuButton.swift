//
//  MenuButton.swift
//  LasersAndMirrors
//
//  Created by Firot on 14.04.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import UIKit
import SpriteKit

class MenuButton: SKNode {
    var labelNode: SKLabelNode!
    
    func configure(_ text: String, at position: CGPoint) {
        labelNode = SKLabelNode(fontNamed: "Audiowide-Regular")
        labelNode.name = "menuButton"
        labelNode.text = text
        labelNode.position = position
        labelNode.horizontalAlignmentMode = .center
        labelNode.fontSize = 24
        addChild(labelNode)
    }
}
