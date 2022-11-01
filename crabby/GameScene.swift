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
    var retangleTop = SKSpriteNode(imageNamed: "bluerectangle")
    var pause = SKSpriteNode(imageNamed: "pause")
    var home = SKSpriteNode(imageNamed: "botaohome")
    var placar = SKSpriteNode(imageNamed: "goal2")
    let background = SKSpriteNode(imageNamed: "BG")
    var newPossibleBubbles = [Bubble(value: 1, operation: .sum, spriteImg: "bubble1sum"),
                              Bubble(value: 2, operation: .sum, spriteImg: "bubble2sum"),
                              Bubble(value: 3, operation: .sum, spriteImg: "bubble3sum"),
                              Bubble(value: 4, operation: .sum, spriteImg: "bubble4sum"),
                              Bubble(value: 5, operation: .sum, spriteImg: "bubble5sum"),
                              Bubble(value: 6, operation: .sum, spriteImg: "bubble6sum"),
                              Bubble(value: 7, operation: .sum, spriteImg: "bubble7sum"),
                              Bubble(value: 8, operation: .sum, spriteImg: "bubble8sum"),
                              Bubble(value: 9, operation: .sum, spriteImg: "bubble9sum"),
                              Bubble(value: 10, operation: .sum, spriteImg: "bubble10sum"),
                              Bubble(value: 1, operation: .sub, spriteImg: "bubble1sub"),
                              Bubble(value: 2, operation: .sub, spriteImg: "bubble2sub"),
                              Bubble(value: 3, operation: .sub, spriteImg: "bubble3sub"),
                              Bubble(value: 4, operation: .sub, spriteImg: "bubble4sub"),
                              Bubble(value: 5, operation: .sub, spriteImg: "bubble5sub"),
                              Bubble(value: 6, operation: .sub, spriteImg: "bubble6sub"),
                              Bubble(value: 7, operation: .sub, spriteImg: "bubble7sub"),
                              Bubble(value: 8, operation: .sub, spriteImg: "bubble8sub"),
                              Bubble(value: 9, operation: .sub, spriteImg: "bubble9sub"),
                              Bubble(value: 10, operation: .sub, spriteImg: "bubble10sub"),
                              Bubble(value: 0, operation: .mult, spriteImg: "bubble0mult"),
                              Bubble(value: 1, operation: .mult, spriteImg: "bubble1mult"),
                              Bubble(value: 2, operation: .mult, spriteImg: "bubble2mult"),
                              Bubble(value: 3, operation: .mult, spriteImg: "bubble3mult"),
                              Bubble(value: 4, operation: .mult, spriteImg: "bubble4mult"),
                              Bubble(value: 5, operation: .mult, spriteImg: "bubble5mult"),
                              Bubble(value: 6, operation: .mult, spriteImg: "bubble6mult"),
                              Bubble(value: 7, operation: .mult, spriteImg: "bubble7mult"),
                              Bubble(value: 8, operation: .mult, spriteImg: "bubble8mult"),
                              Bubble(value: 9, operation: .mult, spriteImg: "bubble9mult"),
                              Bubble(value: 10, operation: .mult, spriteImg: "bubble10mult"),
                              Bubble(value: 1, operation: .div, spriteImg: "bubble1div"),
                              Bubble(value: 2, operation: .div, spriteImg: "bubble2div"),
                              Bubble(value: 3, operation: .div, spriteImg: "bubble3div"),
                              Bubble(value: 4, operation: .div, spriteImg: "bubble4div"),
                              Bubble(value: 5, operation: .div, spriteImg: "bubble5div"),
                              Bubble(value: 6, operation: .div, spriteImg: "bubble6div"),
                              Bubble(value: 7, operation: .div, spriteImg: "bubble7div"),
                              Bubble(value: 8, operation: .div, spriteImg: "bubble8div"),
                              Bubble(value: 9, operation: .div, spriteImg: "bubble9div"),
                              Bubble(value: 10, operation: .div, spriteImg: "bubble10div"),]
    
    var scoreLabel: SKLabelNode!
    var score: Int = 0{
        didSet{
            scoreLabel.text = "\(score)"
        }
    }
    
    var gameTimer: Timer!
    
    let crabCategory: UInt32 = 0x1 << 1
    let bolhaCategory: UInt32 = 0x1 << 0
    
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
        
        gameTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(addBubble), userInfo: nil, repeats: true)
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
        
        bubble.physicsBody = SKPhysicsBody(rectangleOf: bubble.size)
        bubble.physicsBody?.isDynamic = true
        bubble.physicsBody?.categoryBitMask = bolhaCategory
        bubble.physicsBody?.contactTestBitMask = crabCategory
        
        addChild(bubble)
        
        let animationDuration: TimeInterval = 10
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
        
        if (firstBody.categoryBitMask & bolhaCategory) != 0 && (secondBody.categoryBitMask & bubble2Category) != 0 {
            crabDidCollideWithBubble(crabNode: firstBody.node as! SKSpriteNode, bubbleNode: secondBody.node as! SKSpriteNode)
        }
        
        if contact.bodyA.categoryBitMask == crabCategory {
            let touchedBubble = contact.bodyB
            updateScore(bubble: touchedBubble)
        }
        
        if contact.bodyB.categoryBitMask == crabCategory {
            let touchedBubble = contact.bodyA
            updateScore(bubble: touchedBubble)
        }
    }
    
    func updateScore(bubble: SKPhysicsBody) {
        //        print(bubble.node?.userData)
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
    }
    
    func crabDidCollideWithBubble (crabNode: SKSpriteNode, bubbleNode: SKSpriteNode) {
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        explosion.position = bubbleNode.position
        self.addChild(explosion)
        
        self.run(SKAction.playSoundFileNamed("bubbleSound.mp3", waitForCompletion: false))
        crabNode.removeFromParent()
//                bubbleNode.removeFromParent()
        
        self.run(SKAction.wait(forDuration: 1)){
            explosion.removeFromParent()
        }
    }
    
}



