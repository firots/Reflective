//
//  CreditsScene.swift
//  Reflective
//
//  Created by Firot on 12.05.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import UIKit
import SpriteKit

class CreditsScene: SKScene {
    var recognizer: UITapGestureRecognizer!
    var credits = [SKLabelNode]()
    override func didMove(to view: SKView) {
        addBackGround()
        addBackButton()
        if Settings.shadows == true {
            let light = SKLightNode()
            light.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
            light.categoryBitMask = 1
            light.lightColor = UIColor.white
            light.falloff = 0.2
            addChild(light)
        }
        recognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(recognizer)
        addCredit(text: "Designed and developed by\n          Fırat Özsarıkamış", lines: 2)
        addCredit(text: "Music by Eric Matyas\nwww.soundimage.org", lines: 2)
        addCredit(text: "          Laser sound by Dpoggioli\nwww.freesound.org/people/Dpoggioli/", lines: 2)
        

    }
    
    func addCredit(text: String, lines: Int) {
        let credit = SKLabelNode(fontNamed: "Audiowide-Regular")
        credit.preferredMaxLayoutWidth = size.width
        credit.fontSize = 15
        credit.horizontalAlignmentMode = .center
        credit.verticalAlignmentMode = .center
        credit.numberOfLines = lines
        credit.zPosition = 101
        credit.text = text
        var position = CGPoint(x: size.width / 2, y: size.height / 2 - 125)
        if (!credits.isEmpty) {
            position = CGPoint(x: position.x, y: (credits.last?.position.y)! + 80)
        }
        credit.position = position
        credits.append(credit)
        addChild(credit)
    }
    
    @objc func tap(recognizer: UIGestureRecognizer) {
        let viewLocation = recognizer.location(in: view)
        let location = convertPoint(fromView: viewLocation)
        let tappedNodes = nodes(at: location)
        for node in tappedNodes {
            if node.name == "back" {
                mainMenu()
                return
            }
        }
    }
}
