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
            helloWordNode.runAction(moveSequence, completion: {
                let spaceshipSecene = SpaceshipScene(size: (self.view?.frame.size)!)
                let doorTransaction = SKTransition.doorsOpenVerticalWithDuration(0.5);
                self.view?.presentScene(spaceshipSecene, transition: doorTransaction)
            })
        }
    }
}

class SpaceshipScene: SKScene {
    var contentCreated : Bool = false
    
    override func didMoveToView(view: SKView) {
        if contentCreated == false {
            self.createSceneContents()
            self.contentCreated = true
        }
    }
    
    func createSceneContents() {
        self.backgroundColor = SKColor.greenColor()
        self.scaleMode = SKSceneScaleMode.ResizeFill
        
        let spaceship = newSpaceship()
        spaceship.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 150)
        self .addChild(spaceship)
    }
    
    func newSpaceship() -> SKSpriteNode {
        let hull = SKSpriteNode(color: SKColor.grayColor(),  size: CGSizeMake(64, 32))
        
        let hover = SKAction.sequence(
            [SKAction.waitForDuration(1.0),
            SKAction.moveByX(100, y: 50, duration: 1),
            SKAction.waitForDuration(1.0),
            SKAction.moveByX(-100, y: -50, duration: 10.0)])
        hull.runAction(SKAction.repeatActionForever(hover))
        
        let light1 = newLight()
        light1.position = CGPointMake(-28.0, 6.0)
        hull.addChild(light1)
        
        let light2 = newLight()
        light2.position = CGPointMake(28.0, 6)
        hull.addChild(light2)
        
        return hull
    }
    
    func newLight() -> SKSpriteNode {
        let light = SKSpriteNode(color: SKColor.yellowColor(), size: CGSizeMake(8, 8))
        
        let blink = SKAction.sequence(
            [SKAction.fadeOutWithDuration(0.25),
            SKAction.fadeInWithDuration(0.25)])
        let blinkForever = SKAction.repeatActionForever(blink)
        
        light.runAction(blinkForever)
        
        return light
    }
}


