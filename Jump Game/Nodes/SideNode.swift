//
//  SideNode.swift
//  Jump Game
//
//  Created by Indah Nurindo on 30/11/2565 BE.
//

import SpriteKit

class SideNode: SKNode {
    
    //Mark: ~ Properties
    private var node: SKSpriteNode!
    
    
    //Mark: ~ Initializes
    override init() {
        super.init()
        self.name = "Side"
        self.zPosition = 5.0
        
        self.setupPhysics()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//Mark: ~ Setups

extension SideNode {
    
    private func setupPhysics() {
        let size = CGSize(width: 40.0, height: screenHeight)
        node = SKSpriteNode(color: .clear, size: size)
        node.physicsBody = SKPhysicsBody(rectangleOf: size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.friction = 1.0
        node.physicsBody?.restitution = 0
        node.physicsBody?.categoryBitMask = PhysicsCategories.Side
      addChild(node)
    }
}
