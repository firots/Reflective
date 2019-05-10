//
//  Snapper.swift
//  LasersAndMirrors
//
//  Created by Firot on 1.05.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import UIKit
import SpriteKit

class Snapper: SKSpriteNode {
    var direction: SnapDirection!
    static var size: CGSize!
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: nil, color: UIColor.darkGray, size: CGSize(width: 10, height: 10))
        setScale(GameScene.scale)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
