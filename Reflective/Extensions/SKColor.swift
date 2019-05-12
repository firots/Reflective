//
//  SKColor.swift
//  Reflective
//
//  Created by Firot on 12.05.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import Foundation
import SpriteKit

extension SKColor {
    func change(scene: GameScene) -> SKColor {
        let level = scene.currentLevel()
        var newIndex = 0
        for (index, color) in level.order.enumerated() {
            if self == color {
                if index != level.order.count - 1 {
                    newIndex = index + 1
                }
                break
            }
        }
        return level.order[newIndex]
    }
}
