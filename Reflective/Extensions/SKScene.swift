//
//  SKScene.swift
//  Reflective
//
//  Created by Firot on 12.05.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import Foundation
import SpriteKit


extension SKScene {
    @objc func mainMenu() {
        if let scene = SKScene(fileNamed: "MenuScene") as? MenuScene {
            Sound.play("back.wav", scene: scene)
            scene.size = size
            scene.scaleMode = .aspectFit
            view!.presentScene(scene, transition: SKTransition.flipVertical(withDuration: Settings.sceneChangeSpeed))
        }
    }
    
    func addBackButton() {
        let backButton = SKSpriteNode(imageNamed: "exitLeft")
        backButton.zPosition = 101
        backButton.setScale(GameScene.scale)
        backButton.position = CGPoint(x: backButton.size.width / 2, y: self.size.height - backButton.size.height / 2)
        backButton.name = "back"
        addChild(backButton)
    }
    
    func addBackGround() {
        let background = SKSpriteNode(imageNamed: "sci_fi_bg1")
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 + 5)
        background.blendMode = .replace
        background.zPosition = -1
        background.lightingBitMask = 1|2
        background.setScale(GameScene.scale)
        addChild(background)
    }
}
