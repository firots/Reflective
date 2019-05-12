//
//  File.swift
//  LasersAndMirrors
//
//  Created by Firot on 8.05.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import Foundation

struct Settings {
    static let shadows = false
    static var sound = true {
        didSet {
            let defaults = UserDefaults.standard
            defaults.set(!sound, forKey: "sound")
        }
    }
    static var music = true {
        didSet {
            let defaults = UserDefaults.standard
            defaults.set(!music, forKey: "music")
        }
    }
    
    static var test = true
    
    static func load() {
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "sound") {
            sound = false
        } 
        if defaults.bool(forKey: "music") {
            music = false
        } else {
            let dictToSend: [String: String] = ["fileToPlay": "bgmusic" ]
            NotificationCenter.default.post(name: Notification.Name(rawValue: "PlayBackgroundSound"), object: self, userInfo:dictToSend)
        }
    }
    
    
}
