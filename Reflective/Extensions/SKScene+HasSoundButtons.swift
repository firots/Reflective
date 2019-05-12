//
//  SKScene+HasSoundButtons.swift
//  Reflective
//
//  Created by Firot on 12.05.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import Foundation
import SpriteKit

protocol HasSoundButtons {
    func addSoundButtons()
    func toggleMusic(_ button: SKNode)
    func toggleSound(_ button: SKNode)
}

extension HasSoundButtons where Self: SKScene {
    
    func toggleSound(_ button: SKNode) {
        guard let button = button as? SKSpriteNode else { return }
        if Settings.sound == true {
            Settings.sound = false
            button.texture = SKTexture(imageNamed: "audioOff")
            button.color = .red
        } else {
            Settings.sound = true
            button.texture = SKTexture(imageNamed: "audioOn")
            button.color = .white
            Sound.play("back.wav", scene: self)
        }
    }
    
    func toggleMusic(_ button: SKNode) {
        guard let button = button as? SKSpriteNode else { return }
        if Settings.music == true {
            Settings.music = false
            button.texture = SKTexture(imageNamed: "musicOff")
            button.color = .red
            NotificationCenter.default.post(name: Notification.Name(rawValue: "StopBackgroundSound"), object: self)
        } else {
            Settings.music = true
            button.texture = SKTexture(imageNamed: "musicOn")
            button.color = .white
            let dictToSend: [String: String] = ["fileToPlay": "bgmusic" ]
            NotificationCenter.default.post(name: Notification.Name(rawValue: "PlayBackgroundSound"), object: self, userInfo:dictToSend)
        }
    }
    
    func addSoundButtons() {
        var soundImage: String
        var soundColor: UIColor
        if Settings.sound == true {
            soundImage = "audioOn"
            soundColor = .white
        } else {
            soundImage = "audioOff"
            soundColor = .red
        }
        let soundButton = SKSpriteNode(imageNamed: soundImage)
        soundButton.zPosition = 101
        soundButton.setScale(GameScene.scale)
        soundButton.position = CGPoint(x: self.size.width - soundButton.size.width / 2, y: self.size.height - soundButton.size.height / 2)
        soundButton.name = "sound"
        soundButton.color = soundColor
        soundButton.colorBlendFactor = 1
        addChild(soundButton)
        
        var musicImage: String
        var musicColor: UIColor
        if Settings.music == true {
            musicImage = "musicOn"
            musicColor = .white
        } else {
            musicImage = "musicOff"
            musicColor = .red
        }
        let musicButton = SKSpriteNode(imageNamed: musicImage)
        musicButton.zPosition = 101
        musicButton.setScale(GameScene.scale)
        musicButton.position = CGPoint(x: self.size.width - soundButton.size.width * 1.5, y: self.size.height - soundButton.size.height / 2)
        musicButton.name = "music"
        musicButton.color = musicColor
        musicButton.colorBlendFactor = 1
        addChild(musicButton)
    }
}
