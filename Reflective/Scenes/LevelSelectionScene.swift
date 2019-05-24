//
//  LevelSelectionScene.swift
//  LasersAndMirrors
//
//  Created by Firot on 5.05.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import UIKit
import SpriteKit

class LevelSelectionScene: SKScene {
    var tappedLevel = 0
    var page = 0
    var blocks = [Block]()
    var recognizer: UITapGestureRecognizer!
    var nextButtons = [SKLabelNode]()
    var maxLevel: Int!

    override func didMove(to view: SKView) {
        let defaults = UserDefaults.standard
        maxLevel = defaults.integer(forKey: "MaxLevel")
        if maxLevel >= Level.levels.count {
            maxLevel = Level.levels.count - 1
        }
        addBackGround()
        if Settings.shadows == true {
            let light = SKLightNode()
            light.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
            light.categoryBitMask = 1
            if let color = Level.levels[Level.currentLevel].getBallColor() {
                light.lightColor = color
            } else {
                light.lightColor = UIColor.white
            }
            light.falloff = 0.2
            addChild(light)
        }
        recognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(recognizer)
        findCurrentPage()
        addBackButton()
        refresh()
    }
    
    func refresh() {
        placeBlocks()
        addNextButtons()
    }
    
    deinit {
        guard let recognizer = self.recognizer else { return }
        view?.removeGestureRecognizer(recognizer)
    }
    
    @objc func tap(recognizer: UIGestureRecognizer) {
        let viewLocation = recognizer.location(in: view)
        let location = convertPoint(fromView: viewLocation)
        let tappedNodes = nodes(at: location)
        for node in tappedNodes {
            if let block = node as? Block {
                if let tappedLevel = Int(block.name!) {
                    if tappedLevel <= maxLevel + 1 {
                        block.blockBase.color = UIColor.green
                        block.blockBase.shader = Laser.shader
                        Level.currentLevel = tappedLevel
                        mainMenu()
                        return
                    }
                }
            } else {
                if node.name == "back" {
                    mainMenu()
                    return
                } else if node.name == "backPage" {
                    Sound.play("back.wav", scene: self)
                    page -= 1
                    refresh()
                    return
                } else if node.name == "nextPage" {
                    Sound.play("back.wav", scene: self)
                    page += 1
                    refresh()
                    return
                }
            }
        }
    }
    func findCurrentPage() {
        page = (Level.currentLevel - 1) / 40
    }
    
    func removeBlocks() {
        for block in blocks {
            block.removeFromParent()
        }
        blocks.removeAll()
    }
    
    func placeBlocks() {
        removeBlocks()
        var pos = CGPoint(x: Block.size.width * 0.75, y: size.height - Block.size.height * 1.5)
        let start = page * 40 + 1
        var end = start + 39
        if Level.levels.count < end {
            end = Level.levels.count - 1
        }
        for j in start...end {
            createBlock(j, at: pos)
            if (j % 5 == 0) {
                pos.x = Block.size.width * 0.75
                pos.y -= (Block.size.width  * 1.45)
            } else {
                pos.x += (Block.size.width  * 1.5)
            }
        }
    }
    
    func createBlock(_ level: Int, at position: CGPoint) {
        let block = Block()
        block.position = position
        block.zPosition = 10
        block.name = String(level)
        block.blockBase.lightingBitMask = 0
        blocks.append(block)
        if Settings.shadows == true {
            block.blockBase.shadowCastBitMask = 0
            block.blockBase.lightingBitMask = 0
        }
        
        if (maxLevel + 1 >= level) {
            let text = SKLabelNode(fontNamed: "Audiowide-Regular")
            text.horizontalAlignmentMode = .center
            text.verticalAlignmentMode = .center
            text.fontSize = 25
            text.position = CGPoint(x:0, y: 0)
            text.zPosition = 11
            text.text = String(level)
            if (maxLevel >= level) {
                text.fontColor = UIColor.green
            }
            block.addChild(text)
            if Level.currentLevel == level {
                text.color = UIColor.lightGray
            }
        } else {
            let lock = SKSpriteNode(imageNamed: "locked")
            lock.position = CGPoint(x: 0, y: 0)
            lock.zPosition = 1
            lock.size = Block.size
            lock.setScale(0.75)
            block.addChild(lock)
        }

        if Level.currentLevel == level {
            block.blockBase.color = UIColor.lightGray
        }
        addChild(block)
        
    }
    
    func addNextButtons() {
        for nextButton in nextButtons {
            nextButton.removeFromParent()
        }
        nextButtons.removeAll()
        if page < (Level.levels.count - 2) / 40 {
            let backButton = SKLabelNode(fontNamed: "Audiowide-Regular")
            backButton.horizontalAlignmentMode = .center
            backButton.verticalAlignmentMode = .center
            backButton.fontSize = 35
            backButton.position = CGPoint(x: self.size.width - 30, y: 30 )
            backButton.text = ">"
            backButton.name = "nextPage"
            nextButtons.append(backButton)
            addChild(backButton)
        }
        if page > 0 {
            let backButton = SKLabelNode(fontNamed: "Audiowide-Regular")
            backButton.horizontalAlignmentMode = .center
            backButton.verticalAlignmentMode = .center
            backButton.fontSize = 35
            backButton.position = CGPoint(x: 30, y: 30)
            backButton.text = "<"
            backButton.name = "backPage"
            nextButtons.append(backButton)
            addChild(backButton)
        }
    }
}
