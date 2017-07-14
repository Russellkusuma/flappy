//
//  GameViewController.swift
//  Flappy
//
//  Created by iD Student on 7/11/17.
//  Copyright © 2017 iD Tech. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
class GameViewController: UIViewController {

    @IBOutlet weak var resetToOriginalState: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            view.ignoresSiblingOrder = false
            view.showsFPS = true
            view.showsNodeCount = true
        }
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
