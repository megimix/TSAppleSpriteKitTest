//
//  ViewController.swift
//  TSAppleSpriteKitTest
//
//  Created by Tal Shachar on 29/06/2016.
//  Copyright © 2016 Tal Shachar. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let spriteView : SKView = self.view as! SKView
        spriteView.showsFPS  = true
        spriteView.showsDrawCount = true
        spriteView.showsNodeCount = true
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let spriteView : SKView = self.view as! SKView
        
        let hellowScean = HelloScene(size: self.view.bounds.size)
        
        spriteView.presentScene(hellowScean)
    }
}


class HelloScene: SKScene {
    var contentCreated : Bool = false
    
    override func didMoveToView(view: SKView) {
        if contentCreated == false {
            self.createSceneContents()
            self.contentCreated = true
        }
    }
    
    func createSceneContents() {
        self.backgroundColor = SKColor.redColor()
        self.scaleMode = SKSceneScaleMode.ResizeFill

        self.addChild(self.newHelloNode())
    }
    
    func newHelloNode() -> SKLabelNode {
        let hellowNode = SKLabelNode(fontNamed: "Chalkduster")
        hellowNode.text = "Hellow Word"
        hellowNode.name = "helloWordLabel"
        hellowNode.fontSize = 42
        hellowNode.fontColor = UIColor.greenColor()
        hellowNode.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        return hellowNode
    }
}


