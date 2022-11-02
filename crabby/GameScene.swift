//
//  GameScene.swift
//  crabby
//
//  Created by Natália Pessoa de Azevedo Albuquerque on 28/10/22.
//

import SpriteKit
import GameplayKit

enum Operations {
    case sum
    case sub
    case mult
    case div
}

struct Bubble {
    let value: Int
    let operation: Operations
    let spriteImg: String
}

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var crab = SKSpriteNode(imageNamed: "crab")
    var retangleTop = SKSpriteNode(imageNamed: "RETANGULO")
    var pause = SKSpriteNode(imageNamed: "pausa2")
    var goal = SKSpriteNode(imageNamed: "Goal 3")
    let background = SKSpriteNode(imageNamed: "BG")
    var newPossibleBubbles = [Bubble(value: 1, operation: .sum, spriteImg: "BubbleSoma-1"),
                              Bubble(value: 2, operation: .sum, spriteImg: "BubbleSoma-2"),
                              Bubble(value: 3, operation: .sum, spriteImg: "BubbleSoma-3"),
                              Bubble(value: 4, operation: .sum, spriteImg: "BubbleSoma-4"),
                              Bubble(value: 5, operation: .sum, spriteImg: "BubbleSoma-5"),
                              Bubble(value: 6, operation: .sum, spriteImg: "BubbleSoma-6"),
                              Bubble(value: 7, operation: .sum, spriteImg: "BubbleSoma-7"),
                              Bubble(value: 8, operation: .sum, spriteImg: "BubbleSoma-8"),
                              Bubble(value: 9, operation: .sum, spriteImg: "BubbleSoma-9"),
                              Bubble(value: 1, operation: .sub, spriteImg: "BubbleSubtração-1"),
                              Bubble(value: 2, operation: .sub, spriteImg: "BubbleSubtração-2"),
                              Bubble(value: 3, operation: .sub, spriteImg: "BubbleSubtração-3"),
                              Bubble(value: 4, operation: .sub, spriteImg: "BubbleSubtração-4"),
                              Bubble(value: 5, operation: .sub, spriteImg: "BubbleSubtração-5"),
                              Bubble(value: 6, operation: .sub, spriteImg: "BubbleSubtração-6"),
                              Bubble(value: 7, operation: .sub, spriteImg: "BubbleSubtração-7"),
                              Bubble(value: 8, operation: .sub, spriteImg: "BubbleSubtração-8"),
                              Bubble(value: 9, operation: .sub, spriteImg: "BubbleSubtração-9"),
                              Bubble(value: 1, operation: .mult, spriteImg: "BubbleMultiplicação-1"),
                              Bubble(value: 2, operation: .mult, spriteImg: "BubbleMultiplicação-2"),
                              Bubble(value: 3, operation: .mult, spriteImg: "BubbleMultiplicação-3"),
                              Bubble(value: 4, operation: .mult, spriteImg: "BubbleMultiplicação-4"),
                              Bubble(value: 5, operation: .mult, spriteImg: "BubbleMultiplicação-5"),
                              Bubble(value: 6, operation: .mult, spriteImg: "BubbleMultiplicação-6"),
                              Bubble(value: 7, operation: .mult, spriteImg: "BubbleMultiplicação-7"),
                              Bubble(value: 8, operation: .mult, spriteImg: "BubbleMultiplicação-8"),
                              Bubble(value: 9, operation: .mult, spriteImg: "BubbleMultiplicação-9"),
                              Bubble(value: 1, operation: .div, spriteImg: "BubbleDivisão-1"),
                              Bubble(value: 2, operation: .div, spriteImg: "BubbleDivisão-2"),
                              Bubble(value: 3, operation: .div, spriteImg: "BubbleDivisão-3"),
                              Bubble(value: 4, operation: .div, spriteImg: "BubbleDivisão-4"),
                              Bubble(value: 5, operation: .div, spriteImg: "BubbleDivisão-5"),
                              Bubble(value: 6, operation: .div, spriteImg: "BubbleDivisão-6"),
                              Bubble(value: 7, operation: .div, spriteImg: "BubbleDivisão-7"),
                              Bubble(value: 8, operation: .div, spriteImg: "BubbleDivisão-8"),
                              Bubble(value: 9, operation: .div, spriteImg: "BubbleDivisão-9"),]
    
    var scoreLabel: SKLabelNode!
    var score: Int = 0{
        didSet{
            scoreLabel.text = "\(score)"
        }
    }
    var goalLabel: SKLabelNode!
    var goalInt: Int = 0 {
        didSet{
            goalLabel.text = "\(goalInt)"
        }
    }
    
    
    var gameTimer: Timer!
    
    let crabScoreCategory: UInt32 = 0x1 << 1
    let bubbleScoreCategory: UInt32 = 0x1 << 0
    
    let crabExplosionCategory: UInt32 = 0x1 << 0
    let bubbleExplosionCategory: UInt32 = 0x1 << 1
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        background.position = CGPoint(x: self.size.width/2 , y: self.size.height/2)
        background.size = self.size
        background.zPosition = 0
        addChild(background)
        
        crab.position = CGPoint(x: size.width / 2, y: size.height / 8 )
        crab.size = CGSize(width: 400, height: 226)
        addChild(crab)
        
        retangleTop.position = CGPoint(x: size.width / 2, y: (size.height/7)*6)
        retangleTop.size = CGSize(width: 225*1.5, height: 77*1.5)
        retangleTop.zPosition = 3
        addChild(retangleTop)
        
        pause.position = CGPoint(x: (size.width/7)*6, y: (size.height/7)*6)
        pause.size = CGSize(width: 90.5*1.75, height: 90*1.5)
        pause.name = "pauseButton"
        pause.zPosition = 4
        addChild(pause)
        
        goal.position = CGPoint(x: (size.width/7)*1.65, y: (size.height/7)*6)
        goal.size = CGSize(width: 150.26*2, height: 150.26*1.75)
        goal.zPosition = 4
        addChild(goal)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        scoreLabel = SKLabelNode(text: "\(0)")
        scoreLabel.position = CGPoint(x: size.width/2, y: 1110)
        scoreLabel.zPosition = 5
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 64
        scoreLabel.fontColor = UIColor.white
        score = 0
        addChild(scoreLabel)
        
        goalLabel = SKLabelNode(text: "\(goalInt)")
        goalLabel.position = CGPoint(x: size.width / 5, y: 1110)
        goalLabel.zPosition = 5
        goalLabel.fontName = "AmericanTypewriter-Bold"
        goalLabel.fontSize = 48
        goalLabel.fontColor = UIColor.white
        goalInt = Int.random(in: 500...3000)
        addChild( goalLabel)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(addBubble), userInfo: nil, repeats: true)
    }
    
    @objc func addBubble(){
        newPossibleBubbles = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: newPossibleBubbles) as! [Bubble]
        
        let bubble = SKSpriteNode(imageNamed: newPossibleBubbles[0].spriteImg) // SKSpriteNode tem propriedade que pode salvar informações na bolha que está criando
        bubble.userData = NSMutableDictionary() // userData permite salvar essas informações e o NSMutableDictionary() tá inicializando, abrindo espaço na memória para criar um objeto desse tipo
        bubble.userData?.setValue(newPossibleBubbles[0].operation, forKey: "operation")
        bubble.userData?.setValue(newPossibleBubbles[0].value, forKey: "value")
        let randomBubblePosition = GKRandomDistribution(lowestValue: 0, highestValue: 700)
        
        let positon = CGFloat(randomBubblePosition.nextInt())
        
        bubble.zPosition = 1
        bubble.size = CGSize(width: 150, height: 150)
        bubble.position = CGPoint(x: positon, y: size.height + bubble.size.height)
        
        bubble.physicsBody = SKPhysicsBody(circleOfRadius: 150/2)
        bubble.physicsBody?.isDynamic = true
        bubble.physicsBody?.categoryBitMask = bubbleScoreCategory
        bubble.physicsBody?.contactTestBitMask = crabScoreCategory
        
        addChild(bubble)
        
        let animationDuration: TimeInterval = 10
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: positon, y: -bubble.size.height), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        
        bubble.run(SKAction.sequence(actionArray))
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let texture1 = SKTexture(imageNamed: "crab")
        crab.texture = texture1
        crab.physicsBody = SKPhysicsBody(texture: texture1, size: crab.size)
        crab.physicsBody?.categoryBitMask = crabScoreCategory
        crab.physicsBody?.collisionBitMask = bubbleScoreCategory
        crab.physicsBody?.isDynamic = false
        
        for touch in touches {
             let location = touch.location(in: self)
             let touchedNode = atPoint(location)
             if touchedNode.name == "pauseButton" {
                  // Call the function here.
             }
        }

    }
    

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            crab.position.x = location.x
            
            if(abs(crab.position.x) + 200 < size.width){
                crab.position.x = location.x
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody:SKPhysicsBody
        var secondBody:SKPhysicsBody
        
        guard let _ = contact.bodyA.node else { return }
        guard let _ = contact.bodyB.node else { return }
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if contact.bodyA.categoryBitMask == crabScoreCategory {
            let touchedBubble = contact.bodyB
            updateScore(bubble: touchedBubble)
        }
        
        if contact.bodyB.categoryBitMask == crabScoreCategory {
            let touchedBubble = contact.bodyA
            updateScore(bubble: touchedBubble)
        }
        
        if (firstBody.categoryBitMask & crabExplosionCategory) != 0 && (secondBody.categoryBitMask & bubbleExplosionCategory) != 0 {
            crabDidCollideWithBubble(crabNode: secondBody.node as! SKSpriteNode, bubbleNode: firstBody.node as! SKSpriteNode)
        }
    }
    
    func crabDidCollideWithBubble (crabNode: SKSpriteNode, bubbleNode: SKSpriteNode) {
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        explosion.position = bubbleNode.position
        self.addChild(explosion)
        
        self.run(SKAction.playSoundFileNamed("bolha 3.wav", waitForCompletion: false))
        
        //        crabNode.removeFromParent()
        bubbleNode.removeFromParent()
        
        
        self.run(SKAction.wait(forDuration: 1)){
            explosion.removeFromParent()
        }
    }
    
    func updateScore(bubble: SKPhysicsBody) {
        guard let valueFromBubble: Int = bubble.node?.userData?.value(forKey: "value") as? Int else { return }
        guard let operationFromBubble: Operations = bubble.node?.userData?.value(forKey: "operation") as? Operations else { return }
        
        switch operationFromBubble {
        case .sum:
            score += valueFromBubble
        case .sub:
            score -= valueFromBubble
        case .mult:
            score *= valueFromBubble
        case .div:
            score /= valueFromBubble
        }
    
        scoreLabel.text = "\(score)"
        
        if score == goalInt{
            print("foi")
        }
        
    }
}



