//
//  Types.swift
//  Jump Game
//
//  Created by Indah Nurindo on 03/12/2565 BE.
//

import Foundation
import UIKit

let screenWidth: CGFloat = 1536.0
let screenHeight: CGFloat = 2048.0

let appDL = UIApplication.shared.delegate as! AppDelegate

var playableRect: CGRect {
    var ratios: CGFloat = 2.16 //16/9
    
    if appDL.isIPhoneX {
    ratios = 2.16
        
    } else if appDL.isIPad11 {
        ratios = 1.43
    }
    let w: CGFloat = screenHeight / ratios
    let h: CGFloat = screenHeight
    let x: CGFloat = (screenWidth - w) / 2
    let y: CGFloat = 0.0
    
    return CGRect(x: x, y: y, width: w, height: h)
}

struct PhysicsCategories {
    static let Player: UInt32 = 0b1 //2^0
    static let Wall: UInt32 = 0b10 //2^1
    static let Side: UInt32 = 0b100 //2^2
    static let Obstacles: UInt32 = 0b1000 //2^3
    static let Score: UInt32 = 0b10000
}
