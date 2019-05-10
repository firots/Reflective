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
    var backTapped = false
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
            block.blockBase.shadowCastBitMask = 0b0001
            block.blockBase.lightingBitMask = 0b0001
            for snapper in block.snappers {
                if Settings.shadows == true {
                    snapper.shadowCastBitMask = 0b0001
                    snapper.lightingBitMask = 0b0001
                }
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

extension SKScene {
    @objc func mainMenu() {
        if let scene = SKScene(fileNamed: "MenuScene") as? MenuScene {
            Sound.play("back.wav", scene: scene)
            scene.size = size
            scene.scaleMode = .aspectFit
            view!.presentScene(scene, transition: SKTransition.flipVertical(withDuration: 1))
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
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.blendMode = .replace
        background.zPosition = -1
        background.lightingBitMask = 0b0001
        addChild(background)
    }
}




