//
//  Block.swift
//  LasersAndMirrors
//
//  Created by Firot on 20.04.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import UIKit
import SpriteKit

class Block: SKNode {
    static var size: CGSize!
    var blockBase: SKSpriteNode!
    var snappers = [Snapper]()
    let cubeSize = 50
    
    override init() {
        super.init()
        self.name = "block"
        blockBase = SKSpriteNode(texture: nil, color: UIColor.darkGray, size: CGSize(width: cubeSize, height: cubeSize))
        blockBase.physicsBody = SKPhysicsBody(rectangleOf: blockBase.size)
        blockBase.physicsBody?.isDynamic = false
        blockBase.name = "blockBase"
        blockBase.position = CGPoint(x: 0, y: 0)
        blockBase.zPosition = 1
        addChild(blockBase)
        setScale(GameScene.scale)
    }
    
    func addSnapper(at direction: SnapDirection) {
        for snapper in snappers {
            if snapper.direction == direction {
                return
            }
        }
        let snapper = Snapper()
        snapper.zPosition = 1
        snapper.direction = direction
        snapper.position  = setSnapperLoc(for: direction)
        snappers.append(snapper)
        addChild(snapper)
    }
    
    func setSnapperLoc(for direction: SnapDirection) -> CGPoint {
        var pos: CGPoint!
        if (direction == SnapDirection.top) {
            pos = CGPoint(x: 0, y: Block.size.height / 2)
        } else if (direction == SnapDirection.bottom) {
            pos = CGPoint(x: 0, y: Block.size.height / -2)
        } else if (direction == SnapDirection.left) {
            pos = CGPoint(x: Block.size.width / -2, y: 0)
        } else  {
            pos = CGPoint(x: Block.size.width / 2, y: 0)
        }
        return pos
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
