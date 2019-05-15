//
//  Level.swift
//  LasersAndMirrors
//
//  Created by Firot on 14.04.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import Foundation
import SpriteKit

struct Level {
    static var levels = [Level]()
    var order = [SKColor]()
    var mirrors = [SKColor]()
    var cannonColor: SKColor!
    var gameObjects = [GameObjectData]()
    static var currentLevel = 0
    
    static func fill() {
        Level.levels.append(Level(order: [UIColor]() , mirrors: [UIColor](), cannonColor: Colors.red, gameObjects: [BallData(SCPoint(x: 0.5, y: 0.8), Colors.yellow)]))
        
        Level.levels.append(Level(order: [Colors.yellow], mirrors: [SKColor](), cannonColor: Colors.yellow,
        gameObjects: [BallData(SCPoint(x: 0.5, y: 1.5), Colors.yellow)]))
        
        Level.levels.append(Level(order: [Colors.red], mirrors: [SKColor](), cannonColor: Colors.red,
        gameObjects: [BlockData(SCPoint(x: 0.5, y: 0.8), [SnapDirection]()), BallData(SCPoint(x: 0.5, y: 1), Colors.red)]))
        
        Level.levels.append(Level(order: [Colors.red, Colors.yellow] , mirrors: [Colors.red], cannonColor: Colors.red,
        gameObjects: [BlockData(SCPoint(x: 0.5, y: 0.8), [SnapDirection]()), BallData(SCPoint(x: 0.5, y: 1.65), Colors.yellow)]))
        
        Level.levels.append(Level(order: [Colors.red, Colors.yellow, Colors.orange] , mirrors: [Colors.red, Colors.yellow], cannonColor: Colors.red,
        gameObjects: [BallData(SCPoint(x: 0.5, y: 1.65), Colors.orange)]))
        
        Level.levels.append(Level(order: [Colors.red, Colors.yellow] , mirrors: [Colors.red], cannonColor: Colors.red,
        gameObjects: [BlockData(SCPoint(x: 0.5, y: 1), [SnapDirection]()), BallData(SCPoint(x: 0.5, y: 1.2), Colors.yellow)]))
        
        Level.levels.append(Level(order: [Colors.red, Colors.yellow] , mirrors: [Colors.red], cannonColor: Colors.red,
        gameObjects:
            [BlockData(SCPoint(x: 0.5, y: 1), [SnapDirection.bottom]),
             BlockData(SCPoint(x: 0.1, y: 0.5), [SnapDirection]()),
             BlockData(SCPoint(x: 0.2, y: 0.5), [SnapDirection]()),
             BlockData(SCPoint(x: 0.9, y: 0.5), [SnapDirection]()),
             BlockData(SCPoint(x: 0.8, y: 0.5), [SnapDirection]()),
             BallData(SCPoint(x: 0.5, y: 0.8), Colors.yellow)]))
        
        Level.levels.append(Level(order: [Colors.yellow, Colors.purple, Colors.red],
        mirrors: [Colors.yellow, Colors.purple, Colors.red], cannonColor: Colors.yellow,
        gameObjects: [BlockData(SCPoint(x: 0.5, y: 0.8), [SnapDirection]()), BallData(SCPoint(x: 0.5, y: 1.65), Colors.yellow)]))
        
        Level.levels.append(Level(order: [Colors.orange, Colors.red, Colors.yellow, Colors.purple],
        mirrors: [Colors.orange, Colors.red, Colors.yellow], cannonColor: Colors.orange,
        gameObjects: [BlockData(SCPoint(x: 0.35, y: 1), [SnapDirection]()), BlockData(SCPoint(x: 0.65, y: 1), [SnapDirection]()), BlockData(SCPoint(x: 0.5, y: 1.2), [SnapDirection]()), BlockData(SCPoint(x: 0.5, y: 0.8), [SnapDirection]()), BallData(SCPoint(x: 0.5, y: 1), Colors.purple)]))
        
        Level.levels.append(Level(order: [Colors.yellow, Colors.purple, Colors.red, Colors.orange, Colors.green, Colors.blue],
        mirrors: [Colors.yellow, Colors.purple, Colors.red, Colors.orange, Colors.green, Colors.blue], cannonColor: Colors.yellow,
        gameObjects: [BallData(SCPoint(x: 0.5, y: 1.65), Colors.yellow)]))
        
        Level.levels.append(Level(order: [Colors.red, Colors.blue, Colors.yellow, Colors.green],
        mirrors: [Colors.red, Colors.blue, Colors.yellow], cannonColor: Colors.red,
        gameObjects: [BlockData(SCPoint(x: 0.7, y: 1.28), [SnapDirection.right]), BlockData(SCPoint(x: 0.7, y: 1.15), [SnapDirection]()), BlockData(SCPoint(x: 0.7, y: 1.02), [SnapDirection]()), BallData(SCPoint(x: 0.9, y: 1.28), Colors.green)]))
        
        Level.levels.append(Level(order: [Colors.red, Colors.green, Colors.blue, Colors.magenta],
        mirrors: [Colors.red, Colors.green, Colors.blue], cannonColor: Colors.red,
        gameObjects: [BlockData(SCPoint(x: 0.35, y: 1), [SnapDirection.right]), BlockData(SCPoint(x: 0.65, y: 1), [SnapDirection.left]), BlockData(SCPoint(x: 0.5, y: 1.2), [SnapDirection.bottom]), BallData(SCPoint(x: 0.25, y: 0.25), Colors.magenta)]))
        
        Level.levels.append(Level(order: [Colors.magenta, Colors.yellow, Colors.orange, Colors.blue],
        mirrors: [Colors.magenta, Colors.yellow, Colors.orange], cannonColor: Colors.magenta,
        gameObjects: [BlockData(SCPoint(x: 0.75, y: 1.5), [SnapDirection.bottom]), BlockData(SCPoint(x: 0.45, y: 1), [SnapDirection.right]), BlockData(SCPoint(x: 0.9, y: 1.25), [SnapDirection.left]), BallData(SCPoint(x: 0.35, y: 0.22), Colors.blue)]))
        
        Level.levels.append(Level(order: [Colors.yellow, Colors.purple, Colors.red, Colors.orange, Colors.green],
        mirrors: [Colors.yellow, Colors.purple, Colors.red, Colors.orange], cannonColor: Colors.yellow,
        gameObjects: [BlockData(SCPoint(x: 0.5, y: 0.8), [SnapDirection.right]), BlockData(SCPoint(x: 0.65, y: 1), [SnapDirection.bottom]), BallData(SCPoint(x: 0.55, y: 0.2), Colors.green)]))
        
        Level.levels.append(Level(order: [Colors.green, Colors.purple, Colors.red, Colors.orange, Colors.yellow],
        mirrors: [Colors.green, Colors.purple, Colors.red, Colors.orange], cannonColor: Colors.green,
        gameObjects: [BlockData(SCPoint(x: 0.3, y: 1.4), [SnapDirection.bottom]), BlockData(SCPoint(x: 0.5, y: 0.85), [SnapDirection]()), BallData(SCPoint(x: 0.75, y: 0.2), Colors.yellow)]))
        
        Level.levels.append(Level(order: [Colors.blue, Colors.green, Colors.magenta, Colors.red, Colors.yellow],
        mirrors: [Colors.blue, Colors.green, Colors.magenta, Colors.red], cannonColor: Colors.blue,
        gameObjects: [BlockData(SCPoint(x: 0.64, y: 0.64), [SnapDirection.left]), BlockData(SCPoint(x: 0.31, y: 1.28), [SnapDirection.bottom]), BallData(SCPoint(x: 0.1, y: 0.25), Colors.yellow)]))
        
        Level.levels.append(Level(order: [Colors.orange, Colors.red, Colors.yellow, Colors.magenta, Colors.green, Colors.blue],
        mirrors: [Colors.orange, Colors.red, Colors.yellow, Colors.magenta, Colors.green, Colors.blue], cannonColor: Colors.orange,
        gameObjects: [BlockData(SCPoint(x: 0.3, y: 0.8), [SnapDirection.right]), BlockData(SCPoint(x: 0.5, y: 1.05), [SnapDirection]()), BlockData(SCPoint(x: 0.5, y: 0.55), [SnapDirection]()),  BlockData(SCPoint(x: 0.7, y: 0.8), [SnapDirection.left]), BlockData(SCPoint(x: 0.8, y: 0.8), [SnapDirection]()), BlockData(SCPoint(x: 0.9, y: 0.8), [SnapDirection]()), BlockData(SCPoint(x: 0.2, y: 0.8), [SnapDirection]()), BlockData(SCPoint(x: 0.1, y: 0.8), [SnapDirection]()), BallData(SCPoint(x: 0.2, y: 1.5), Colors.orange)]))
        
        
        Level.levels.append(Level(order: [Colors.green, Colors.red, Colors.yellow, Colors.blue],
        mirrors: [Colors.green, Colors.red, Colors.yellow], cannonColor: Colors.green,
        gameObjects: [BlockData(SCPoint(x: 0.8, y: 1.5), [SnapDirection.bottom]), BlockData(SCPoint(x: 0.2, y: 1.5), [SnapDirection.bottom]), BallData(SCPoint(x: 0.8, y: 0.2), Colors.blue)]))
        
        
        Level.levels.append(Level(order: [Colors.red, Colors.green, Colors.blue, Colors.magenta, Colors.orange],
        mirrors: [Colors.red, Colors.green, Colors.blue, Colors.magenta], cannonColor: Colors.red,
        gameObjects: [BlockData(SCPoint(x: 0.1, y: 1), [SnapDirection.right]), BlockData(SCPoint(x: 0.5, y: 1), [SnapDirection.left]), BlockData(SCPoint(x: 0.7, y: 1), [SnapDirection]()), BlockData(SCPoint(x: 0.9, y: 1), [SnapDirection.bottom]), BallData(SCPoint(x: 0.5, y: 1.2), Colors.orange)]))
        
        
        Level.levels.append(Level(order: [Colors.green, Colors.yellow, Colors.orange, Colors.purple, Colors.blue, Colors.red],
            mirrors: [Colors.green, Colors.yellow, Colors.orange, Colors.purple, Colors.blue],
            cannonColor: Colors.green,
            gameObjects:
            [BlockData(SCPoint(x: 0.5, y: 1), [SnapDirection.bottom]),
             BlockData(SCPoint(x: 0.1, y: 0.5), [SnapDirection]()),
             BlockData(SCPoint(x: 0.2, y: 0.5), [SnapDirection.right]),
             BlockData(SCPoint(x: 0.9, y: 0.5), [SnapDirection]()),
             BlockData(SCPoint(x: 0.8, y: 0.5), [SnapDirection.left]),
             BallData(SCPoint(x: 0.5, y: 0.8), Colors.red)]))
        
        Level.levels.append(Level(order: [Colors.yellow, Colors.orange, Colors.red, Colors.purple, Colors.blue, Colors.green, Colors.magenta],
            mirrors: [Colors.yellow, Colors.orange, Colors.red, Colors.purple, Colors.blue, Colors.green],
            cannonColor: Colors.yellow,
            gameObjects:
            [BlockData(SCPoint(x: 0.1, y: 0.5), [SnapDirection]()),
             BlockData(SCPoint(x: 0.8, y: 0.15), [SnapDirection.top]),
             BlockData(SCPoint(x: 0.3, y: 0.4), [SnapDirection]()),
             BlockData(SCPoint(x: 0.4, y: 0.3), [SnapDirection]()),
             BlockData(SCPoint(x: 0.4, y: 0.7), [SnapDirection]()),
             BlockData(SCPoint(x: 0.5, y: 0.7), [SnapDirection.bottom]),
             BlockData(SCPoint(x: 0.6, y: 0.7), [SnapDirection]()),
             BlockData(SCPoint(x: 0.8, y: 0.8), [SnapDirection]()),
             BallData(SCPoint(x: 0.6, y: 1.5), Colors.magenta)]))
        
        Level.levels.append(Level(order: [Colors.magenta, Colors.yellow, Colors.orange, Colors.blue],
            mirrors: [Colors.magenta, Colors.yellow, Colors.orange],
            cannonColor: Colors.magenta,
            gameObjects:
            [BlockData(SCPoint(x: 0.1, y: 0.3), [SnapDirection]()),
             BlockData(SCPoint(x: 0.2, y: 0.5), [SnapDirection.top]),
             BlockData(SCPoint(x: 0.7, y: 1.4), [SnapDirection.left]),
             BlockData(SCPoint(x: 0.4, y: 1.2), [SnapDirection]()),
             BlockData(SCPoint(x: 0.3, y: 1.0), [SnapDirection]()),
             BlockData(SCPoint(x: 0.5, y: 0.7), [SnapDirection]()),
             BlockData(SCPoint(x: 0.3, y: 0.3), [SnapDirection]()),
             BlockData(SCPoint(x: 0.6, y: 0.4), [SnapDirection]()),
             BallData(SCPoint(x: 0.3, y: 1.5), Colors.blue)]))
        
        
        Level.levels.append(Level(order: [Colors.green, Colors.blue, Colors.yellow, Colors.orange, Colors.red, Colors.magenta],
        mirrors: [Colors.green, Colors.blue, Colors.yellow, Colors.orange, Colors.red],
        cannonColor: Colors.green,
        gameObjects:
            [BlockData(SCPoint(x: 0.1, y: 0.5), [SnapDirection]()),
            BlockData(SCPoint(x: 0.2, y: 0.5), [SnapDirection.right]),
            BlockData(SCPoint(x: 0.9, y: 0.5), [SnapDirection]()),
            BlockData(SCPoint(x: 0.8, y: 0.5), [SnapDirection.left]),
            BlockData(SCPoint(x: 0.4, y: 0.8), [SnapDirection]()),
            BlockData(SCPoint(x: 0.35, y: 0.9), [SnapDirection.left]),
            BlockData(SCPoint(x: 0.5, y: 0.8), [SnapDirection]()),
            BlockData(SCPoint(x: 0.6, y: 0.8), [SnapDirection]()),
            BlockData(SCPoint(x: 0.65, y: 0.9), [SnapDirection.right]),
            BallData(SCPoint(x: 0.5, y: 1.1), Colors.magenta)]))
        
        
        
        Level.levels.append(Level(order: [Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.orange],
        mirrors: [Colors.red, Colors.blue, Colors.green, Colors.yellow],
        cannonColor: Colors.red,
        gameObjects:
            [BlockData(SCPoint(x: 0.1, y: 1.5), [SnapDirection.bottom]),
             BlockData(SCPoint(x: 0.3, y: 1.5), [SnapDirection.bottom]),
             BlockData(SCPoint(x: 0.5, y: 1.5), [SnapDirection.bottom]),
             BlockData(SCPoint(x: 0.7, y: 1.5), [SnapDirection.bottom]),
             BlockData(SCPoint(x: 0.9, y: 1.5), [SnapDirection.bottom]),
             BallData(SCPoint(x: 0.5, y: 0.3), Colors.orange)]))
        
        
        
        Level.levels.append(Level(order: [Colors.yellow, Colors.orange, Colors.red, Colors.purple, Colors.blue, Colors.green, Colors.magenta],
            mirrors: [Colors.yellow, Colors.orange, Colors.red, Colors.purple, Colors.blue, Colors.green, Colors.magenta],
            cannonColor: Colors.yellow,
            gameObjects:
            [BlockData(SCPoint(x: 0.1, y: 0.3), [SnapDirection.right]),
             BlockData(SCPoint(x: 0.4, y: 0.3), [SnapDirection.left]),
             
             BlockData(SCPoint(x: 0.1, y: 0.45), [SnapDirection.right]),
             BlockData(SCPoint(x: 0.4, y: 0.45), [SnapDirection.left]),
             
             BlockData(SCPoint(x: 0.1, y: 0.6), [SnapDirection.right]),
             BlockData(SCPoint(x: 0.4, y: 0.6), [SnapDirection.left]),
             
             BlockData(SCPoint(x: 0.1, y: 0.75), [SnapDirection.right]),
             BlockData(SCPoint(x: 0.4, y: 0.75), [SnapDirection.left]),
             
             BlockData(SCPoint(x: 0.1, y: 0.9), [SnapDirection.right]),
             BlockData(SCPoint(x: 0.4, y: 0.9), [SnapDirection.left]),
             
             BlockData(SCPoint(x: 0.1, y: 1.05), [SnapDirection.right]),
             BlockData(SCPoint(x: 0.4, y: 1.05), [SnapDirection.left]),
             
             BlockData(SCPoint(x: 0.1, y: 1.2), [SnapDirection.right]),
             BlockData(SCPoint(x: 0.4, y: 1.2), [SnapDirection.left]),
             
             BlockData(SCPoint(x: 0.1, y: 1.35), [SnapDirection.right]),
             BlockData(SCPoint(x: 0.4, y: 1.35), [SnapDirection.left]),
             
             BlockData(SCPoint(x: 0.1, y: 1.5), [SnapDirection.right]),
             BlockData(SCPoint(x: 0.4, y: 1.5), [SnapDirection.left]),
             
             BallData(SCPoint(x: 0.25, y: 1.6), Colors.yellow)]))
        
        
        Level.levels.append(Level(order: [Colors.yellow, Colors.orange, Colors.red, Colors.purple, Colors.blue, Colors.green, Colors.magenta],
            mirrors: [Colors.yellow, Colors.orange, Colors.red, Colors.purple, Colors.blue, Colors.green],
            cannonColor: Colors.yellow,
            gameObjects:
            [BlockData(SCPoint(x: 0.1, y: 0.3), [SnapDirection.left]),
             BlockData(SCPoint(x: 0.2, y: 0.5), [SnapDirection.right]),
             BlockData(SCPoint(x: 0.3, y: 0.7), [SnapDirection.right]),
             BlockData(SCPoint(x: 0.4, y: 0.9), [SnapDirection.right]),
             BlockData(SCPoint(x: 0.5, y: 1.1), [SnapDirection.left]),
             BlockData(SCPoint(x: 0.6, y: 1.3), [SnapDirection.right]),
             BlockData(SCPoint(x: 0.7, y: 1.5), [SnapDirection.bottom]),
             BlockData(SCPoint(x: 0.6, y: 1.8), [SnapDirection.bottom]),
             BallData(SCPoint(x: 0.25, y: 1.6), Colors.magenta)]))
        
        
        
        Level.levels.append(Level(order: [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue],
            mirrors: [Colors.red, Colors.orange, Colors.yellow, Colors.green],
            cannonColor: Colors.red,
            gameObjects:
            [BlockData(SCPoint(x: 0.1, y: 0.3), [SnapDirection.left]),
             BlockData(SCPoint(x: 0.7, y: 0.4), [SnapDirection.right]),
             BlockData(SCPoint(x: 0.5, y: 0.7), [SnapDirection.right]),
             BlockData(SCPoint(x: 0.2, y: 0.3), [SnapDirection.right]),
             BlockData(SCPoint(x: 0.2, y: 1.3), [SnapDirection.left]),
             BlockData(SCPoint(x: 0.4, y: 1.2), [SnapDirection.right]),
             BlockData(SCPoint(x: 0.5, y: 1.2), [SnapDirection.bottom]),
             BlockData(SCPoint(x: 0.75, y: 1.4), [SnapDirection.bottom]),
             BallData(SCPoint(x: 0.4, y: 1.35), Colors.blue)]))


        let defaults = UserDefaults.standard
        //defaults.set(0, forKey: "MaxLevel") lock all
        Level.currentLevel = defaults.integer(forKey: "MaxLevel") + 1
        if Level.currentLevel >= Level.levels.count {
            Level.currentLevel = Level.levels.count - 1
        }
        if Settings.test == true {
            defaults.set(Level.levels.count - 1, forKey: "MaxLevel")
            Level.currentLevel = Level.levels.count - 1
        }
    }
}


struct SCPoint {
    let x: CGFloat
    let y: CGFloat
}

struct BlockData: GameObjectData {
    var position: SCPoint
    var snappers = [SnapDirection]()
    
    init(_ position: SCPoint, _ snappers: [SnapDirection]) {
        self.position = position
        self.snappers = snappers
    }
}

struct BallData: GameObjectData {
    var position: SCPoint
    var color: UIColor
    
    init(_ position: SCPoint, _ color: UIColor) {
        self.position = position
        self.color = color
    }
}

protocol GameObjectData {
    var position: SCPoint { get set }
}

enum SnapDirection {
    case all
    case bottom
    case top
    case right
    case left
}


