//
//  WallNode.swift
//  Jump Game
//
//  Created by Indah Nurindo on 30/11/2565 BE.
//

import SpriteKit

class WallNode: SKNode {
    
    //Mark: ~ Properties
    private var node: SKSpriteNode!
    
    
    //Mark: ~ Initializes
    override init() {
        super.init()
        self.name = "Wall"
        self.zPosition = 5.0
        
        self.setupPhysics()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//Mark: ~ Setups

extension WallNode {
    
    private func setupPhysics() {
        let size = CGSize(width: screenWidth, height: 40.0)
        node = SKSpriteNode(color: .clear, size: size)
        node.physicsBody = SKPhysicsBody(rectangleOf: size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.mass = 100.0
        node.physicsBody?.restitution = 1.0
        node.physicsBody?.categoryBitMask = PhysicsCategories.Wall
        node.physicsBody?.collisionBitMask = PhysicsCategories.Player
      addChild(node)
    }
}

