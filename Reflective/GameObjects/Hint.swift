//
//  Hint.swift
//  Reflective
//
//  Created by Firot on 12.05.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import UIKit
import SpriteKit

class Hint: SKNode {
    let label: SKLabelNode
    override init() {
        label = SKLabelNode(fontNamed: "Audiowide-Regular")
        super.init()
    }
    
    convenience init(animated: Bool, text: String) {
        self.init()
        label.text = text
        label.fontSize = 12
        if animated == true {
            self.label.startBeating()
        }
        label.zPosition = 101
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
