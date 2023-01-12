//
//  HUDNode.swift
//  Jump Game
//
//  Created by Indah Nurindo on 12/01/2566 BE.
//

import SpriteKit

class HUDNode: SKNode {
    
    //Mark: ~ Properties
    private var topScoreShape: SKShapeNode!
    private var topScorLbl: SKLabelNode!
    
    //Mark: ~ Initializes
    override init() {
        super.init()
       setupTopScore()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//Mark: ~ Setups

extension HUDNode {
    
    private func setupTopScore() {
        let statusH: CGFloat = appDL.isIPhoneX ? 88 : 40
        let scoreY: CGFloat = screenHeight - (statusH + 90/2 + 20)
        topScoreShape = SKShapeNode(rectOf: CGSize(width: 220, height: 90), cornerRadius: 8.0)
        topScoreShape.fillColor = UIColor(hex: 0x000000, alpha: 0.5)
        topScoreShape.zPosition = 20.0
        topScoreShape.position = CGPoint(x: screenWidth/2, y: scoreY)
//       topScorLbl = SKLabelNode()
    }
}
