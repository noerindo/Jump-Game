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
    
    private var gameOverShape: SKShapeNode!
    private var gameOverNode: SKSpriteNode!
    
    private var homeNode: SKSpriteNode!
    private var againNode: SKSpriteNode!
    
    private var scoreTitleLbl: SKLabelNode!
    private var scoreLbl: SKLabelNode!
    private var highscoreTitleLbl: SKLabelNode!
    private var highscoreLbl: SKLabelNode!
    
    var easeScene: GameScene?
    var skView: SKView!
    
    private var isHome = false {
        didSet {
            updateBtn(node: homeNode, event: isHome)
        }
    }
    private var isAgain = false {
        didSet {
            updateBtn(node: againNode, event: isAgain)
        }
    }
    
    //Mark: ~ Initializes
    override init() {
        super.init()
       setupTopScore()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // ketika klik button
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return}
        let node = atPoint(touch.location(in: self))
        
        if node.name == "Home" && !isHome {
            isHome = true
        }
        if node.name == "PlayAgain" && !isAgain {
            isAgain = true
        }
    }
    //ketika melepas klikan button
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if isHome {
            isHome = false
        }
        if isAgain {
            isAgain = false
            
            if let _ = easeScene {
                let scene = GameScene(size: CGSize(width: screenWidth, height: screenHeight))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let touch = touches.first else {return}
        
        if let parent = homeNode?.parent{
            isHome = homeNode.contains(touch.location(in: parent))
        }
        
        if let parent = againNode?.parent{
            isHome = againNode.contains(touch.location(in: parent))
        }
    }
}

//Mark: ~ Setups

extension HUDNode {
    //Animasi Btn
    private func updateBtn(node: SKNode, event: Bool) {
        var alpha: CGFloat = 1.0
        if event {
            alpha = 0.5
        }
        node.run(.fadeAlpha(by: alpha, duration: 0.1))
    }
    
    private func setupTopScore() {
        let statusH: CGFloat = appDL.isIPhoneX ? 88 : 40
        let scoreY: CGFloat = screenHeight - (statusH + 90/2 + 20)
        
        topScoreShape = SKShapeNode(rectOf: CGSize(width: 220, height: 90), cornerRadius: 8.0)
        topScoreShape.fillColor = UIColor(hex: 0x000000, alpha: 0.5)
        topScoreShape.zPosition = 20.0
        topScoreShape.position = CGPoint(x: screenWidth/2, y: scoreY)
        addChild(topScoreShape)
        
        self.topScorLbl = SKLabelNode(fontNamed: FontName.verdana)
        topScorLbl.fontSize = 60.0
        topScorLbl.text = "0"
        topScorLbl.fontColor = .white
        topScorLbl.zPosition = 25.0
        topScorLbl.position = CGPoint(x: topScoreShape.frame.midX, y: topScoreShape.frame.midY - topScorLbl.frame.height/2)
        addChild(topScorLbl)

    }
    func updateScore(_ score: Int) {
        topScorLbl.text = "\(score)"
        print("\(score)")
        topScorLbl.run(.sequence([
            .scale(to: 1.3, duration: 0.1),
            .scale(to: 1.0, duration: 0.1),
        ]))
    }
}

//MARK: GameOver
extension HUDNode {

    func setupGameOver(_ score: Int, _ highscore: Int) {
        gameOverShape = SKShapeNode(rect: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight))
        gameOverShape.zPosition = 49.0
        gameOverShape.fillColor = UIColor(hex: 0x000000, alpha: 0.7)
        addChild(gameOverShape)
        
         isUserInteractionEnabled = true
        
        let scale: CGFloat = appDL.isIPhoneX ? 0.6 : 0.7
        
        //TODO: - GmeoevrNode
        gameOverNode = SKSpriteNode(imageNamed: "panel-gameOver")
        gameOverNode.setScale(scale)
        gameOverNode.zPosition = 50.0
        gameOverNode.position = CGPoint(x: screenWidth/2, y: screenHeight/2)
        addChild(gameOverNode)
        
        //TODO: - HomeNode
        homeNode = SKSpriteNode(imageNamed: "icon-home")
        homeNode.setScale(scale)
        homeNode.zPosition = 55.0
        homeNode.position = CGPoint(x: gameOverNode.frame.minX + homeNode.frame.width/2 + 30, y: gameOverNode.frame.minY + homeNode.frame.height/2 + 30)
        homeNode.name = "Home"
        addChild(homeNode)
        
        //TODO: - PlayAgainNode
        againNode = SKSpriteNode(imageNamed: "icon-playAgain")
        againNode.setScale(scale)
        againNode.zPosition = 55.0
        againNode.position = CGPoint(x: gameOverNode.frame.maxX - homeNode.frame.width/2 - 30, y: gameOverNode.frame.minY + homeNode.frame.height/2 + 30)
        againNode.name = "PlayAgain"
        addChild(againNode)
        
        //TODO: -  scoreTitleLbl
        scoreTitleLbl = SKLabelNode(fontNamed:  FontName.verdana)
        scoreTitleLbl.fontSize = 60.0
        scoreTitleLbl.text = "Score: "
        scoreTitleLbl.fontColor = .white
        scoreTitleLbl.zPosition = 55.0
        scoreTitleLbl.position = CGPoint(x: gameOverNode.frame.minX + scoreTitleLbl.frame.width/2 + 30, y: screenHeight/2)
        addChild(scoreTitleLbl)
        
        //TODO: -  scoreLbl
        scoreLbl = SKLabelNode(fontNamed: FontName.verdana)
        scoreLbl.fontSize = 60.0
        scoreLbl.text = "\(score)"
        scoreLbl.fontColor = .white
        scoreLbl.zPosition = 55.0
        scoreLbl.position = CGPoint(x: gameOverNode.frame.maxX -  scoreLbl.frame.width/2 - 30, y: scoreTitleLbl.position.y)
        addChild( scoreLbl)
        
        //TODO: -  highscoreTitleLbl
        highscoreTitleLbl = SKLabelNode(fontNamed:  FontName.verdana)
        highscoreTitleLbl.fontSize = 60.0
        highscoreTitleLbl.text = "Highscore: "
        highscoreTitleLbl.fontColor = .white
        highscoreTitleLbl.zPosition = 55.0
        highscoreTitleLbl.position = CGPoint(x: gameOverNode.frame.minX +  highscoreTitleLbl.frame.width/2 + 30, y: screenHeight/2-highscoreTitleLbl.frame.height*2)
        addChild( highscoreTitleLbl)
        
        //TODO: -  highscoreLbl
        highscoreLbl = SKLabelNode(fontNamed: FontName.verdana)
        highscoreLbl.fontSize = 60.0
        highscoreLbl.text = "\(highscore)"
        highscoreLbl.fontColor = .white
        highscoreLbl.zPosition = 55.0
        highscoreLbl.position = CGPoint(x: gameOverNode.frame.maxX -  highscoreLbl.frame.width/2 - 30, y: highscoreTitleLbl.position.y)
        addChild( highscoreLbl)
    }
}
