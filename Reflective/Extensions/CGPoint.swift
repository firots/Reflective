//
//  CGPoint.swift
//  Reflective
//
//  Created by Firot on 12.05.2019.
//  Copyright © 2019 Firot. All rights reserved.
//

import Foundation
import SpriteKit

extension CGPoint {
    func distance(point: CGPoint) -> CGFloat {
        return abs(CGFloat(hypotf(Float(point.x - x), Float(point.y - y))))
    }
}
