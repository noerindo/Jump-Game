//
//  GameViewController.swift
//  Jump Game
//
//  Created by Indah Nurindo on 21/11/2565 BE.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let view = self.view as? SKView else {
            return
            
        }
        
        let scene = GameScene(size: CGSize(width: screenWidth, height: screenHeight))
        scene.scaleMode = .aspectFill
        
        
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        view.showsPhysics = false
        view.presentScene(scene)

        }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
