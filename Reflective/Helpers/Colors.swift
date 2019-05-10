//
//  Colors.swift
//  LasersAndMirrors
//
//  Created by Firot on 27.04.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import Foundation
import SpriteKit

struct Colors {
    
    static let purple = UIColor.purple
    static let magenta =  UIColor.magenta
    static let blue = UIColor.blue
    static let green = UIColor.green
    static let yellow = UIColor.yellow
    static let orange =  UIColor.orange
    static let red = UIColor.red
    static let white = UIColor.white

}

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
