//
//  GameScene.swift
//  crabby
//
//  Created by Natália Pessoa de Azevedo Albuquerque on 28/10/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var crab = SKSpriteNode(imageNamed: "crab")
    var retangleTop = SKSpriteNode(imageNamed: "bluerectangle")
    var pause = SKSpriteNode(imageNamed: "pause")
    var home = SKSpriteNode(imageNamed: "botaohome")
    var placar = SKSpriteNode(imageNamed: "goal2")
    let background = SKSpriteNode(imageNamed: "BG")
    var possibleBubbles = ["bubble1", "bubble2", "bubble3", "bubble4", "bubble5", "bubble6", "bubble7", "bubble8", "bubble9", "bubble10"]
    var scoreLabel: SKLabelNode!
    var score: Int = 0{
        didSet{
            scoreLabel.text = "\(score)"
        }
    }
    
    var gameTimer: Timer!
    
    let crabCategory: UInt32 = 1
    let bolhaCategory: UInt32 = 2
    let scoreCategory: UInt32 = 4
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        background.position = CGPoint(x: self.size.width/2 , y: self.size.height/2)
        background.size = self.size
        background.zPosition = 0
        addChild(background)
        
        crab.position = CGPoint(x: size.width / 2, y: size.height / 8 )
        crab.size = CGSize(width: 400, height: 226)
        addChild(crab)
        
        retangleTop.position = CGPoint(x: size.width / 2, y: 1250)
        retangleTop.size = CGSize(width: size.width, height: (size.width/5)*3)
        retangleTop.zPosition = 3
        addChild(retangleTop)
        
        pause.position = CGPoint(x: (size.width/7)*6, y: (size.height/7)*6)
        pause.size = CGSize(width: 150, height: 150)
        pause.zPosition = 4
        addChild(pause)
        
        home.position = CGPoint(x: (size.width/7), y: (size.height/7)*6)
        home.size = CGSize(width: 150, height: 150)
        home.zPosition = 4
        addChild(home)
        
        placar.position = CGPoint(x: size.width / 2, y: 1150)
        placar.size = CGSize(width: 300, height: 190)
        placar.zPosition = 4
        addChild(placar)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        scoreLabel = SKLabelNode(text: "\(0)")
        scoreLabel.position = CGPoint(x: size.width / 2, y: 1150)
        scoreLabel.zPosition = 5
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = UIColor.black
        score = 0
        addChild(scoreLabel)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(addBubble), userInfo: nil, repeats: true)
    }
    
    @objc func addBubble(){
        possibleBubbles = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleBubbles) as! [String]
        
        let bubble = SKSpriteNode(imageNamed: possibleBubbles[0])
        let randomBubblePosition = GKRandomDistribution(lowestValue: 0, highestValue: 700)
        
        let positon = CGFloat(randomBubblePosition.nextInt())
        
        bubble.zPosition = 1
        bubble.size = CGSize(width: 150, height: 150)
        bubble.position = CGPoint(x: positon, y: size.height + bubble.size.height)
        
        bubble.physicsBody = SKPhysicsBody(rectangleOf: bubble.size)
        bubble.physicsBody?.isDynamic = true
        bubble.physicsBody?.categoryBitMask = bolhaCategory
        bubble.physicsBody?.contactTestBitMask = crabCategory
        
        addChild(bubble)
        
        let animationDuration: TimeInterval = 4
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: positon, y: -bubble.size.height), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        
        bubble.run(SKAction.sequence(actionArray))
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        crab.physicsBody = SKPhysicsBody(rectangleOf: crab.size)
        crab.physicsBody?.categoryBitMask = crabCategory
        crab.physicsBody?.collisionBitMask = bolhaCategory
        crab.physicsBody?.isDynamic = false
    }
    
    
    
    //    func didBegin(_ contact: SKPhysicsContact) {
    //        if contact.bodyA.categoryBitMask == crabCategory || contact.bodyB.categoryBitMask == crabCategory{
    //            score += 1
    //            scoreLabel.text = "\(score)"
    //        }
    //    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            crab.position.x = location.x
            
            if(abs(crab.position.x) + 200 < size.width){
                crab.position.x = location.x
            }
        }
    }
    
    let bubbleCategory: UInt32 = 0x1 << 1
    let bubble2Category: UInt32 = 0x1 << 0
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & bubbleCategory) != 0 && (secondBody.categoryBitMask & bubble2Category) != 0 {
            crabDidCollideWithBubble(crabNode: firstBody.node as! SKSpriteNode, bubbleNode: secondBody.node as! SKSpriteNode)
        }
        
        if contact.bodyA.categoryBitMask == crabCategory || contact.bodyB.categoryBitMask == crabCategory{
            score += 1
            scoreLabel.text = "\(score)"
        }
        
    }
    
    func crabDidCollideWithBubble (crabNode: SKSpriteNode, bubbleNode: SKSpriteNode) {
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        explosion.position = bubbleNode.position
        addChild(explosion)
        
        self.run(SKAction.playSoundFileNamed("bubbleSound.mp3", waitForCompletion: false))
        crabNode.removeFromParent()
        bubbleNode.removeFromParent()
        
        self.run(SKAction.wait(forDuration: 2)){
            explosion.removeFromParent()
        }
        
        score += 5 // NO MEU É DIFERENTE
    }
    
}



