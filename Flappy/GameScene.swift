//
//  GameScene.swift
//  Flappy
//
//  Created by iD Student on 7/11/17.
//  Copyright © 2017 iD Tech. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreGraphics
class GameScene: SKScene, SKPhysicsContactDelegate {
    var myBackground = SKSpriteNode()
    var myFloor1 = SKSpriteNode()
    var myFloor2 = SKSpriteNode()
    var ufo = SKSpriteNode()
    var bottomObstacle1 = SKSpriteNode()
    var bottomObstacle2 = SKSpriteNode()
    var topObstacle1 = SKSpriteNode()
    var topObstacle2 = SKSpriteNode()
    var start = Bool(false)
    var birdIsActive = Bool(false)
    var obstacleHeight = CGFloat(200)
    let birdCategory:UInt32 = 0x1 << 0
    let pipeCategory:UInt32 = 0x1 << 1


    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsWorld.contactDelegate = self
        
        myBackground = SKSpriteNode(imageNamed: "background")
        myBackground.anchorPoint = CGPoint.zero;
        
        myBackground.position = CGPoint(x: 0, y: 150)
        self.backgroundColor = UIColor.black

        addChild(myBackground)

        myFloor1 = SKSpriteNode(imageNamed: "floor")
        myFloor2 = SKSpriteNode(imageNamed: "floor")
        myFloor1.anchorPoint = CGPoint.zero;
        myFloor1.position = CGPoint(x: 0,y: 0);
        myFloor2.anchorPoint = CGPoint.zero;
        myFloor2.position = CGPoint(x: myFloor1.size.width-1,y: 0);
        addChild(myFloor1)
        addChild(myFloor2)
        
        ufo = SKSpriteNode(imageNamed: "UFO")
        ufo.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        ufo.size.width = ufo.size.width / 10
        ufo.size.height = ufo.size.height / 10
        addChild(self.ufo)

        bottomObstacle1 = SKSpriteNode(imageNamed: "Obstacle")
        bottomObstacle2 = SKSpriteNode(imageNamed: "Obstacle")
        topObstacle1 = SKSpriteNode(imageNamed: "Obstacle")
        topObstacle2 = SKSpriteNode(imageNamed: "Obstacle")
        
        bottomObstacle1.position = CGPoint(x: 800,y: 200);
        bottomObstacle1.size.height = bottomObstacle1.size.height / 2
        bottomObstacle1.size.width = bottomObstacle1.size.width / 2
        
        bottomObstacle2.position = CGPoint(x: 1600,y: 200);
        bottomObstacle2.size.height = bottomObstacle2.size.height / 2
        bottomObstacle2.size.width = bottomObstacle2.size.width / 2
        
        topObstacle1.position = CGPoint(x: 800,y: 200 * 5);
        topObstacle1.size.height = topObstacle1.size.height / 2
        topObstacle1.size.width = topObstacle1.size.width / 2
        
        topObstacle2.position = CGPoint(x: 1600,y: 200 * 5);
        topObstacle2.size.height = topObstacle2.size.height / 2
        topObstacle2.size.width = topObstacle2.size.width / 2

        addChild(self.bottomObstacle1)
        addChild(self.bottomObstacle2)
        addChild(self.topObstacle1)
        addChild(self.topObstacle2)
        

    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        start = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        myFloor1.position = CGPoint(x: myFloor1.position.x-4,y: myFloor1.position.y);
        myFloor2.position = CGPoint(x: myFloor2.position.x-4,y: myFloor2.position.y);
        
        if (myFloor1.position.x < -myFloor1.size.width){
            myFloor1.position = CGPoint(x: myFloor2.position.x + myFloor2.size.width,y: myFloor1.position.y);
        }
        
        if (myFloor2.position.x < -myFloor2.size.width) {
            myFloor2.position = CGPoint(x: myFloor1.position.x + myFloor1.size.width,y: myFloor2.position.y);
        }
        if (start) {
            bottomObstacle1.position = CGPoint(x: bottomObstacle1.position.x-8,y: 200);
            bottomObstacle2.position = CGPoint(x: bottomObstacle2.position.x-8,y: bottomObstacle2.position.y);
            topObstacle1.position = CGPoint(x: topObstacle1.position.x-8,y: 800);
            topObstacle2.position = CGPoint(x: topObstacle2.position.x-8,y: 700);
            
            if (bottomObstacle1.position.x < -bottomObstacle1.size.width / 2){
                bottomObstacle1.position = CGPoint(x: bottomObstacle2.position.x + bottomObstacle2.size.width * 4,y: obstacleHeight);
                topObstacle1.position = CGPoint(x: topObstacle2.position.x + topObstacle2.size.width * 4,y: obstacleHeight);
            }
            
            if (bottomObstacle2.position.x < -bottomObstacle2.size.width / 2) {
                bottomObstacle2.position = CGPoint(x: bottomObstacle1.position.x + bottomObstacle1.size.width * 4,y: obstacleHeight);
                topObstacle2.position = CGPoint(x: topObstacle1.position.x + topObstacle1.size.width * 4,y: obstacleHeight);
            }
            
            if (bottomObstacle1.position.x < 750/2)
            {
                obstacleHeight = randomBetweenNumbers(firstNum: 0, secondNum: 240)
            }
            
        }
    }
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
        
    }
}
