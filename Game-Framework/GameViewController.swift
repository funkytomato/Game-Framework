//
//  GameViewController.swift
//  Game-Framework
//
//  Created by cadet on 04/07/2017.
//  Copyright © 2017 cadet. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let aspectRatio = view.bounds.size.width / view.bounds.size.height
        
        //        let scene = GameScene(size:CGSize(width: 640 * aspectRatio, height: 640))
        let scene = GameScene(size:CGSize(width: 1000 * aspectRatio, height: 650))
        //        let scene = GameScene(size:CGSize(width: 1000, height: 650))
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        
        //scene.scaleMode = .aspectFill
        //scene.scaleMode = .aspectFit
        scene.scaleMode = .resizeFill
        
        skView.presentScene(scene)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
