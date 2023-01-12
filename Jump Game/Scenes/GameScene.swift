//
//  GameScene.swift
//  Jump Game
//
//  Created by Indah Nurindo on 21/11/2565 BE.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    //Mark:  ~ Properties
    private var worldNode = SKNode()
    private var bgNode = SKSpriteNode()
    private let hudNode = HUDNode()
    
    private let playerNode = PlayerNode(diff: 0)
    private let wallNode = WallNode()
    private let leftNode = SideNode()
    private let rightNode = SideNode()
    private let obstacleNode = SKNode()
    
    private var firsTap = true
    private var posY: CGFloat = 0.0
    private var pairNum = 0
    private var score = 0
   //Mark:  ~ Lifecycle
    override func didMove(to view: SKView) {
    setupNodes()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        
        if firsTap {
            playerNode.activate(true)
            firsTap = false
        }
        let location = touch.location(in: self)
        let right = !(location.x > frame.width/2)
//         var right = true
//        if location.x > frame.width/2 {
//            right = false
//        }
        playerNode.jump(right)
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if -playerNode.height() + frame.midY < worldNode.position.y {
            worldNode.position.y = -playerNode.height() + frame.midY
        }
        if posY - playerNode.height() < frame.midY {
            addObstactles()
        }
        obstacleNode.children.forEach({
            let i = score - 2
            if $0.name == "Pair\(i)" {
                $0.removeFromParent()
                print("removeFromParent")
            }
        })
    }
}

//Mark:  ~ Setups

extension GameScene {
    private func setupNodes() {
        backgroundColor = .white
         //TODO: Background
        addBG()
        
        //TODO: ~ WorldNode
        addChild(worldNode)
        
        //TODO: ~ PlayerNode
        playerNode.position = CGPoint(x: frame.midX, y: frame.midY*0.6)
        worldNode.addChild(playerNode)
        
        //TODO: ~ WallNode
        addWall()
        
        //TODO: ~ obstacleNode
        worldNode.addChild(obstacleNode)
        posY = frame.midY
    }
    private func setupPhysics() {
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -15.0)
        physicsWorld.contactDelegate = self    }
}
//Mark: ~ Background

extension GameScene {
    private func addBG() {
        bgNode = SKSpriteNode(imageNamed: "background")
        bgNode.zPosition = -1.0
        bgNode.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(bgNode)
    }
}
//Mark: ~ WallNode

extension GameScene {
    private func addWall() {
        wallNode.position = CGPoint(x: frame.midX, y:0.0)
        leftNode.position = CGPoint(x: playableRect.minX, y: frame.midY)
        rightNode.position = CGPoint(x: playableRect.maxX, y: frame.midY)
        
        addChild(wallNode)
        addChild(leftNode)
        addChild(rightNode)
    }
}
//TODO: ~ ObstacleNode
extension GameScene {
    private func addObstactles() {
        let pipePair = SKNode()
        pipePair.position = CGPoint(x: 0.0, y: posY)
        pipePair.zPosition = 1.0
        
        pairNum += 1
        pipePair.name = "Pair\(pairNum)"
        
        let size = CGSize(width: screenWidth, height: 50.0)
        let pipe_1 = SKSpriteNode(color: .black, size: size)
        pipe_1.position = CGPoint(x: -250, y: 0.0)
        pipe_1.physicsBody = SKPhysicsBody(rectangleOf: size)
        pipe_1.physicsBody?.isDynamic = false
        pipe_1.physicsBody?.categoryBitMask = PhysicsCategories.Obstacles
        
        let pipe_2 = SKSpriteNode(color: .black, size: size)
        pipe_2.position = CGPoint(x: pipe_1.position.x + size.width + 250, y: 0.0)
        pipe_2.physicsBody = SKPhysicsBody(rectangleOf: size)
        pipe_2.physicsBody?.isDynamic = false
        pipe_2.physicsBody?.categoryBitMask = PhysicsCategories.Obstacles
        
        let score = SKNode()
        score.position = CGPoint(x: 0.0, y: size.height)
        score.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width*2, height: size.height))
        score.physicsBody?.isDynamic = false
        score.physicsBody?.categoryBitMask = PhysicsCategories.Score
        
        pipePair.addChild(pipe_1)
        pipePair.addChild(pipe_2)
        pipePair.addChild(score)
        
        obstacleNode.addChild(pipePair)
        posY += frame.midY * 0.7
    }
}
// Mark: - Gameover
extension GameScene {
    
    private func gameOver() {
        playerNode.over()
    }
}

//Mark: - BackgroundNode
extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let body = contact.bodyA.categoryBitMask == PhysicsCategories.Player ? contact.bodyB :
        contact.bodyA
        
        switch body.categoryBitMask {
        case PhysicsCategories.Wall:
            gameOver()
        case PhysicsCategories.Side:
            playerNode.side()
        case PhysicsCategories.Obstacles:
            print("Obtacles")
        case PhysicsCategories.Score:
            if let node = body.node {
                score += 1
                node.removeFromParent()
            }
        default: break
        }
    }
}
///hahah
