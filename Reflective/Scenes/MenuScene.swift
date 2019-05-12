//
//  MenuScene.swift
//  LasersAndMirrors
//
//  Created by Firot on 28.04.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class MenuScene: SKScene, HasSoundButtons {
    var menuButtons = [MenuButton]()
    var light: SKLightNode!
    var recognizer: UITapGestureRecognizer!
    var startButton: StartButton!

    func addMenuButton(_ text: String, at position: CGPoint) {
        let button = MenuButton()
        button.configure(text, at: position)
        addChild(button)
        menuButtons.append(button)
    }
    
    override func didMove(to view: SKView) {
        //addMenuButton("Start Game", at: CGPoint(x: self.size.width / 2, y: self.size.height / 2))
        startButton = StartButton()
        startButton.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        addChild(startButton)
        addBackGround()
        addSoundButtons()
        if Settings.shadows == true {
            light = SKLightNode()
            light.position = startButton.position
            light.categoryBitMask = 1
            light.lightColor = UIColor.white
            light.falloff = 0.2
            addChild(light)
        }
        addMenuButton("Level: \(Level.currentLevel)" , at: CGPoint(x: self.size.width / 2, y: self.size.height / 2 - 150))
        recognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(recognizer)
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
            if let nodeLabel = node as? SKLabelNode {
                if (nodeLabel.text?.starts(with: "Level"))! {
                    levelSelection()
                    return
                }
            } else if let _ = node as? StartButton {
                startGame()
                return
            } else if node.name == "sound" {
                toggleSound(node)
                return
            } else if node.name == "music" {
                toggleMusic(node)
                return
            }
        }
    }

    func levelSelection() {
        if let scene = SKScene(fileNamed: "LevelSelectionScene") as? LevelSelectionScene {
            Sound.play("back.wav", scene: self)
            scene.size = size
            scene.scaleMode = .aspectFit
            view!.presentScene(scene, transition: SKTransition.flipVertical(withDuration: 1))
        }
    }
    
    func startGame() {
        if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
            startButton.logo.shader = Laser.shader
            Sound.play("back.wav", scene: self)
            scene.size = size
            scene.scaleMode = .aspectFit
            scene.level = Level.currentLevel
            view!.presentScene(scene, transition: SKTransition.flipVertical(withDuration: 1))
        }
    }
}
