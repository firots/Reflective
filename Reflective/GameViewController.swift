//
//  GameViewController.swift
//  LasersAndMirrors
//
//  Created by Firot on 14.04.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    var bgSoundPlayer:AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.playBackgroundSound(_:)), name: NSNotification.Name(rawValue: "PlayBackgroundSound"), object: nil) //add this to play audio
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.stopBackgroundSound), name: NSNotification.Name(rawValue: "StopBackgroundSound"), object: nil) //add this to stop the audio

        if let view = self.view as! SKView? {
            setScaling(view: view)
            if let scene = SKScene(fileNamed: "MenuScene") {
                scene.size = view.frame.size
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            if Settings.test == true {
                //view.showsFPS = true
                //view.showsNodeCount = true
            }
        }
    }
    
    func setScaling(view: SKView) {
        let scale = view.frame.size.width / 375
        let cubeSize: CGFloat = 50
        GameScene.scale = scale
        Level.fill()
        Settings.load()
        Mirror.size = CGSize(width: cubeSize * 2 * scale, height: (cubeSize + 10) * scale)
        Block.size = CGSize(width: cubeSize * scale, height: cubeSize * scale)
        Cannon.size = CGSize(width: 40 * scale, height: 60 * scale)
        Snapper.size = CGSize(width: 10 * scale, height: 10 * scale)
        var spawnPosX = view.frame.size.width
        spawnPosX -= 10
        Mirror.spawnPos = CGPoint(x: spawnPosX, y: Mirror.size.height / 2 + 10)
    }
    
    
    @objc func playBackgroundSound(_ notification: Notification) {
        
        //get the name of the file to play from the data passed in with the notification
        let name = (notification as NSNotification).userInfo!["fileToPlay"] as! String
        
        
        //if the bgSoundPlayer already exists, stop it and make it nil again
        if (bgSoundPlayer != nil){
            
            bgSoundPlayer!.stop()
            bgSoundPlayer = nil
            
            
        }
        
        //as long as name has at least some value, proceed...
        if (name != ""){
            
            //create a URL variable using the name variable and tacking on the "mp3" extension
            let fileURL:URL = Bundle.main.url(forResource:name, withExtension: "mp3")!
            
            //basically, try to initialize the bgSoundPlayer with the contents of the URL
            do {
                bgSoundPlayer = try AVAudioPlayer(contentsOf: fileURL)
            } catch _{
                bgSoundPlayer = nil
                
            }
            
            bgSoundPlayer!.volume = 0.75 //set the volume anywhere from 0 to 1
            bgSoundPlayer!.numberOfLoops = -1 // -1 makes the player loop forever
            bgSoundPlayer!.prepareToPlay() //prepare for playback by preloading its buffers.
            bgSoundPlayer!.play() //actually play
            
        }
        
        
    }
    
    
    
    @objc func stopBackgroundSound() {
        
        //if the bgSoundPlayer isn't nil, then stop it
        if (bgSoundPlayer != nil){
            
            bgSoundPlayer!.stop()
            bgSoundPlayer = nil
            
            
        }
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
}
