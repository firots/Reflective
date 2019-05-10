//
//  Sound.swift
//  LasersAndMirrors
//
//  Created by Firot on 10.05.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import Foundation
import SpriteKit

struct Sound {
    static func play(_ fileName: String, scene: SKScene?) {
        guard let scene = scene else { return }
        if Settings.sound == true {
            let sound = SKAction.playSoundFileNamed(fileName, waitForCompletion: false)
            scene.run(sound)
        }
    }
}
