//
//  GameScene.swift
//  LasersAndMirrors
//
//  Created by Firot on 14.04.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import SpriteKit
import GameplayKit



class GameScene: SKScene, HasSoundButtons {
    
    var mirrors = [Mirror]()
    var hints = [Hint]()
    var blocks = [Block]()
    var level: Int! {
        didSet {
            Level.currentLevel = level!
        }
    }
    var draggingMirror: Mirror?
    var cannon: Cannon?
    var lasers = [Laser]()
    var guide: Laser?
    var ball: Ball?
    var won = false
    static var scale: CGFloat = 1.0
    var recognizer: UITapGestureRecognizer!
    
    var remeaningMirrors: Int! {
        didSet {
            if remeaningMirrors == nil || remeaningMirrors <= 0  {
                mirrorCounter.isHidden = true
            } else {
                mirrorCounter.text = "\(remeaningMirrors!)x"
                mirrorCounter.isHidden = false
            }
            
        }
    }
    var mirrorCounter: SKLabelNode!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        for node in tappedNodes {
            if cannon!.isShooting() == false && won == false {
                if node.name == "mirror" {
                    if let mirror = node as? Mirror {
                        draggingMirror = mirror
                        return
                    }
                } else if node.name == "cannon" {
                    cannon!.dragging = 0
                    return
                }
            }
        }
        if let cannon = cannon {
            if cannon.isShooting() == false && won == false {
                cannon.rotating = location
            }
        }
    }
    
    deinit {
        guard let recognizer = self.recognizer else { return }
        view?.removeGestureRecognizer(recognizer)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            if let node = self.draggingMirror {
                node.position = touchLocation
            }
            else if let cannon = self.cannon {
                if cannon.rotating != nil {
                    cannon.rotate(to: touchLocation, at: touch.timestamp)
                } else if cannon.dragging > -1 {
                    if touchLocation.x > Cannon.size.width / 2 && touchLocation.x < self.size.width - Cannon.size.width / 2 && touchLocation.y < Cannon.size.height * 2 {
                        cannon.position.x = touchLocation.x
                    }
                    cannon.dragging = 1
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let node = draggingMirror {
            let _ = node.beginSnap(at: node.position)
        }
        if let cannon = cannon {
            cannon.stopRotating()
            cannon.dragging = -1
        }
    }
    
    
    @objc func tap(recognizer: UIGestureRecognizer) {
        let viewLocation = recognizer.location(in: view)
        let location = convertPoint(fromView: viewLocation)
        let tappedNodes = nodes(at: location)
        for node in tappedNodes {
            if cannon!.isShooting() == false && won == false && cannon!.dragging < 1 {
                if  let _ = node as? Mirror { return }
                if node.name == "cannon" {
                    cannon?.fire()
                    return
                }
                else if node.name == "back" {
                    mainMenu()
                    return
                }
                else if node.name == "sound" {
                    toggleSound(node)
                    return
                }
                else if node.name == "music" {
                    toggleMusic(node)
                    return
                }
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let node = draggingMirror {
            let _ = node.beginSnap(at: node.position)
        }
        if let cannon = cannon {
            cannon.stopRotating()
            cannon.dragging = -1
        }
    }

    override func didMove(to view: SKView) {
        addBackGround()
        addMirrorCounter()
        spawnCannon()
        spawnMirrors()
        addBackButton()
        addSoundButtons()
        spawnGameObjects()
        addHints()
        recognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(recognizer)
    }

    func resetDraggingMirror() {
        if let mirror = draggingMirror {
            if let snappedPos = mirror.snappedPos {
                mirror.position = snappedPos
            } else {
                mirror.position = Mirror.spawnPos
            }
        }
        self.draggingMirror = nil
    }
    
    func addMirrorCounter() {
        mirrorCounter = SKLabelNode(fontNamed: "Audiowide-Regular")
        mirrorCounter.horizontalAlignmentMode = .center
        mirrorCounter.fontSize = 24
        mirrorCounter.position = CGPoint(x: Mirror.spawnPos.x - Mirror.size.width / 4, y: Mirror.spawnPos.y)
        mirrorCounter.isHidden = true
        addChild(mirrorCounter)
    }
    
    func addHints() {
        if level == 1 {
            if let cannon = self.cannon {
                let hint = Hint(animated: true, text: "tap cannon to fire")
                hint.position = CGPoint(x: 0, y: Cannon.size.height)
                hints.append(hint)
                cannon.addChild(hint)
            }
        } else if level == 2 {
            if let cannon = self.cannon {
                let dragHint = Hint(animated: true, text: "drag cannon to left or right")
                dragHint.position = CGPoint(x: 0, y: Cannon.size.height)
                hints.append(dragHint)
                cannon.addChild(dragHint)
            }
            if let ball = self.ball {
                let aimHint = Hint(animated: true, text: "swipe right or left to aim")
                aimHint.position = CGPoint(x: ball.position.x, y: ball.position.y + Cannon.size.height)
                hints.append(aimHint)
                addChild(aimHint)
            }
        } else if level == 3 {
            let mirrorHint = Hint(animated: true, text: "drag mirror in the bottom of screen to screen edges and reflect laser from it")
            mirrorHint.label.preferredMaxLayoutWidth = size.width / 2
            mirrorHint.label.numberOfLines = 3
            mirrorHint.position = CGPoint(x: size.width / 2, y: size.height / 2)
            hints.append(mirrorHint)
            addChild(mirrorHint)
        } else if level == 6 {
            if  !blocks.isEmpty {
                let block = blocks[0]
                let snapHint = Hint(animated: true, text: "drag mirror to my bottom :)")
                snapHint.position = CGPoint(x: 0, y: 0)
                hints.append(snapHint)
                block.addChild(snapHint)
            }

        }
    }
    
    func wonLevel() {
        if (won == false) {
            won = true
            let defaults = UserDefaults.standard
            let maxLevel = defaults.integer(forKey: "MaxLevel")
            if level > maxLevel {
                defaults.set(level, forKey: "MaxLevel")
            }
            if level < Level.levels.count - 1 {
                perform(#selector(nextLevel), with: nil, afterDelay: 1.8)
            } else {
                perform(#selector(mainMenu), with: nil, afterDelay: 1.8)
            }
        }
    }
    
    @objc func nextLevel() {
        changeLevel(to: level + 1)
    }
    
    func gameOver() {
        
    }
    
    func changeLevel(to level: Int) {
        if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
            Sound.play("back.wav", scene: self)
            scene.size = size
            scene.scaleMode = .aspectFit
            scene.level = level
            view!.presentScene(scene, transition: SKTransition.flipVertical(withDuration: 1))
        }
    }
    
    func currentLevel() -> Level {
        return Level.levels[level!]
    }
    
    func spawnCannon() {
        cannon = Cannon()
        if let cannon = self.cannon {
            cannon.position = CGPoint(x: self.size.width / 2, y: 0)
            addChild(cannon)
            cannon.color = currentLevel().cannonColor
        }
    }
    
    func spawnBall(ballData: BallData) {
        ball = Ball()
        if let ball = self.ball {
            ball.position = createPos(from: ballData.position)
            ball.color = ballData.color
            let text = SKLabelNode(fontNamed: "Audiowide-Regular")
            text.horizontalAlignmentMode = .center
            text.verticalAlignmentMode = .center
            text.fontSize = 100
            text.position = CGPoint(x:0, y: 0)
            text.zPosition = 11
            text.text = String(level)
            ball.addChild(text)
            addChild(ball)
        }
    }
    
    func createPos(from scalingPos: SCPoint) -> CGPoint {
        return CGPoint(x: scalingPos.x * size.width, y: scalingPos.y * size.width)
    }
    
    func spawnMirrors() {
        remeaningMirrors = currentLevel().mirrors.count
        for color in currentLevel().mirrors {
            let iMirror = Mirror()
            iMirror.position = Mirror.spawnPos
            iMirror.zPosition = 11
            iMirror.color = color
            addChild(iMirror)
            mirrors.append(iMirror)
        }
    }
    
    func spawnGameObjects() {
        for gameObject in currentLevel().gameObjects {
            if let block = gameObject as? BlockData {
                spawnBlock(blockData: block)
            }
            else if let ball = gameObject as? BallData {
                spawnBall(ballData: ball)
            }
        }
    }

    func spawnBlock(blockData: BlockData) {
        let block = Block()
        var snapperData = blockData.snappers
        block.position = createPos(from: blockData.position)
        block.zPosition = 10
        if snapperData.isEmpty == false {
            if blockData.snappers[0] == SnapDirection.all {
                snapperData = [SnapDirection.top, SnapDirection.bottom, SnapDirection.right, SnapDirection.left]
            }
        }
        for snapper in snapperData {
            block.addSnapper(at: snapper)
        }
        if Settings.shadows == true {
            block.blockBase.shadowCastBitMask = 1
            block.blockBase.lightingBitMask = 1|2
            for snapper in block.snappers {
                snapper.shadowCastBitMask = 0
                snapper.lightingBitMask = 1|2
            }
        }
        addChild(block)
        blocks.append(block)
    }
    


    func mirrorAt(_ position: CGPoint, mirror: Mirror) -> Mirror? {
        for m in mirrors {
            if mirror != m && Int(m.position.x) == Int(position.x) && abs(m.position.y - position.y) < Mirror.size.height  {

                return m
            }
        }
        return nil
    }
}








