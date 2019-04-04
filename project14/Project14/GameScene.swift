//
//  GameScene.swift
//  Project14
//
//  Created by Brad Thurlow on 28/3/19.
//  Copyright © 2019 Brad Thurlow. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var slots = [WhackSlot]()
    var gameScore: SKLabelNode!
    
    var popUpTime = 0.85
    var numRound = 0
    
    var score = 0 {
        didSet {
            gameScore.text = "Score \(score)"
        }
    }

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)
        
        for i in 0..<5 {
            createSlot(at: CGPoint(x: 100 + (i * 170), y: 410))
        }
        for i in 0..<4 {
            createSlot(at: CGPoint(x: 180 + (i * 170), y: 320))
        }
        for i in 0..<5 {
            createSlot(at: CGPoint(x: 100 + (i * 170), y: 230))
        }
        for i in 0..<4 {
            createSlot(at: CGPoint(x: 180 + (i * 170), y: 140))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[weak self] in
            self?.createEnemy()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let tappedNodes = nodes(at: location)
            
            for node in tappedNodes {
                if node.name == "charFriend" {
                    // they shouldn't have whacked this penguin
                    let whackSlot = node.parent!.parent as! WhackSlot
                    if !whackSlot.isVisible { continue }
                    if whackSlot.isHit { continue }
                    
                    whackSlot.hit()
                    smokeParticle(location: location)
                    
                    score -= 5
                    
                    run(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion:false))
                } else if node.name == "charEnemy" {
                    // they should have whacked this one
                    let whackSlot = node.parent!.parent as! WhackSlot
                    if !whackSlot.isVisible { continue }
                    if whackSlot.isHit { continue }
                    
                    whackSlot.charNode.xScale = 0.85
                    whackSlot.charNode.yScale = 0.85
                    
                    whackSlot.hit()
                    smokeParticle(location: location)
                    
                    score += 1
                    run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion:false))
                }
            }
        }
    }
    
    func smokeParticle(location: CGPoint) {
        if let smokeParticles = SKEmitterNode(fileNamed: "smokePs.sks") {
            smokeParticles.position = location
            smokeParticles.zPosition = 1
            smokeParticles.particleLifetime = 1
            let addEmitterAction = SKAction.run { [weak self] in
                self?.addChild(smokeParticles)
            }
            let delay = SKAction.wait(forDuration: 0.8)
            let remove = SKAction.run {
                [weak self] in
                smokeParticles.removeFromParent()
            }
            let sequence = SKAction.sequence([addEmitterAction, delay, remove])
            self.run(sequence)
        }
    }
    
    func createSlot(at position: CGPoint) {
        let slot = WhackSlot()
        slot.configure(at: position)
        addChild(slot)
        slots.append(slot)
    }
    
    func createEnemy() {
        numRound += 1
        
        if numRound >= 30 {
            for slot in slots {
                slot.hide()
            }
            
            let finalScoreText = SKLabelNode(fontNamed: "chalkDuster")
            finalScoreText.text = "Final Score \(score)"
            finalScoreText.position = CGPoint(x: 512, y: 300)
            finalScoreText.horizontalAlignmentMode = .center
            finalScoreText.fontSize = 60
            finalScoreText.zPosition = 1
            addChild(finalScoreText)
            
            let gameOver = SKSpriteNode(imageNamed: "gameOver")
            gameOver.position = CGPoint(x: 512, y: 384)
            gameOver.zPosition = 1
            addChild(gameOver)
            return
        }
        
        
        popUpTime *= 0.991
        
        slots.shuffle()
        slots[0].show(hideTime: popUpTime)
        
        if Int.random(in: 0...12) > 4 {
            slots[1].show(hideTime: popUpTime)
        }
        if Int.random(in: 0...12) > 8 {
            slots[2].show(hideTime: popUpTime)
        }
        if Int.random(in: 0...12) > 10 {
            slots[3].show(hideTime: popUpTime)
        }
        if Int.random(in: 0...12) > 11 {
            slots[4].show(hideTime: popUpTime)
        }
        
        let minDelay = popUpTime / 2.0
        let maxDelay = popUpTime * 2
        let delay = Double.random(in: minDelay ... maxDelay)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {[weak self] in
            self?.createEnemy()
        }
    }
    
}

