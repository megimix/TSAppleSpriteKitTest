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
    let helloWordLabelName = "helloWordLabel"
    
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
        hellowNode.name = helloWordLabelName
        hellowNode.fontSize = 42
        hellowNode.fontColor = UIColor.greenColor()
        hellowNode.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        return hellowNode
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let helloWordNode = self.childNodeWithName(helloWordLabelName) {
            helloWordNode.name = nil
            let moveUp = SKAction.moveByX(0, y: 100, duration: 0.5);
            let zoom = SKAction.scaleTo(2, duration: 0.25)
            let pusee = SKAction.waitForDuration(0.5)
            let fadeAway = SKAction.fadeOutWithDuration(0.25)
            let remove = SKAction.removeFromParent()
            let moveSequence = SKAction.sequence([moveUp, zoom, pusee, fadeAway, remove])
            helloWordNode.runAction(moveSequence)
        }
    }
}


