//
//  TitleScene.swift
//  FlappyBird
//
//  Created by AiTH2 on 2018/12/26.
//  Copyright © 2018 hirohisa.kimura. All rights reserved.
//

import UIKit
import SpriteKit

class TitleScene: SKScene {
    
    var scrollNode: SKNode!
    var bird: SKSpriteNode!
    let SPRITE_NAME_START_BUTTON = "startButton"
    
    override func didMove(to view: SKView) {
        
        backgroundColor = UIColor(red: 0.15, green: 0.75, blue: 0.90, alpha: 1)
        
        // スクロールするスプライトの親ノード
        scrollNode = SKNode()
        addChild(scrollNode)
        
        setupTitleLogo()
        setupStartButton()
        setupGround()
        setupCloud()
        setupBird()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            
            //STARTをタップするとゲームを始めるようにする
            if (touchedNode.name != nil) {
                if (touchedNode.name == SPRITE_NAME_START_BUTTON){
                    let newScene = GameScene(size: self.scene!.size)
                    newScene.scaleMode = SKSceneScaleMode.aspectFill
                    self.view!.presentScene(newScene)
                }
            }
        }
    }
    
    func setupTitleLogo() {
        let titleLogoTexture = SKTexture(imageNamed: "title_logo")
        titleLogoTexture.filteringMode = .linear
        
        let sprite = SKSpriteNode(texture: titleLogoTexture)
        sprite.size = ObjectSize.titleLogoSize()
        sprite.position = CGPoint(
            x: self.frame.width * 0.5,
            y: self.frame.height * 0.75
        )
        self.addChild(sprite)
    }
    
    func setupStartButton() {
        let startButtonTexture = SKTexture(imageNamed: "start_button")
        startButtonTexture.filteringMode = .linear
        
        let sprite = SKSpriteNode(texture: startButtonTexture)
        sprite.size = ObjectSize.startButtonSize()
        sprite.position = CGPoint(
            x: self.frame.width * 0.5,
            y: self.frame.height * 0.18
        )
        sprite.name = SPRITE_NAME_START_BUTTON
        self.addChild(sprite)
    }
    
    func setupGround(){
        // 地面の画像を読み込む
        let groundTexture = SKTexture(imageNamed: "ground")
        groundTexture.filteringMode = .nearest
        // 必要な枚数を計算
        let needNumber = Int(self.frame.size.width / groundTexture.size().width) + 2
        
        // スクロールするアクションを作成
        // 左方向に画像一枚分スクロールさせるアクション
        let moveGround = SKAction.moveBy(x: -groundTexture.size().width, y: 0, duration: 5)
        
        // 元の位置に戻すアクション
        let resetGround = SKAction.moveBy(x: groundTexture.size().width, y: 0, duration: 0)
        
        // 左にスクロール->元の位置->左にスクロールと無限に繰り返すアクション
        let repeatScrollGround = SKAction.repeatForever(SKAction.sequence([moveGround, resetGround]))
        
        
        // groundのスプライトを配置する
        for i in 0..<needNumber {
            let sprite = SKSpriteNode(texture: groundTexture)
            
            // スプライトの表示する位置を指定する
            sprite.position = CGPoint(
                x: groundTexture.size().width / 2  + groundTexture.size().width * CGFloat(i),
                y: groundTexture.size().height / 2
            )
            
            // スプライトにアクションを設定する
            sprite.run(repeatScrollGround)
            
            // スプライトを追加する
            scrollNode.addChild(sprite)
        }
        
    }
    
    func setupCloud(){
        
        let cloudTexture = SKTexture(imageNamed: "cloud")
        cloudTexture.filteringMode = .nearest
        
        let needCloudNumber = Int(self.frame.size.width / cloudTexture.size().width) + 2
        
        let moveCloud = SKAction.moveBy(x: -cloudTexture.size().width, y: 0, duration: 20)
        
        let resetCloud = SKAction.moveBy(x: cloudTexture.size().width, y: 0, duration: 0)
        
        let repeatScrollCloud = SKAction.repeatForever(SKAction.sequence([moveCloud, resetCloud]))
        
        for i in 0..<needCloudNumber {
            let sprite = SKSpriteNode(texture: cloudTexture)
            sprite.zPosition = -100
            
            sprite.position = CGPoint(
                x: cloudTexture.size().width / 2 + cloudTexture.size().width * CGFloat(i),
                y: self.size.height - cloudTexture.size().height / 2
            )
            
            sprite.run(repeatScrollCloud)
            scrollNode.addChild(sprite)
        }
        
    }
    
    func setupBird() {
        // 鳥の画像を2種類読み込む
        let imageA = UIImage(named:"onna_a")
        let a = imageA?.resize(image: imageA!, width: 70.0)
        let imageB = UIImage(named:"onna_b")
        let b = imageA?.resize(image: imageB!, width: 70.0)
        
        let birdTextureA = SKTexture(image: a!)
        birdTextureA.filteringMode = .linear
        
        let birdTextureB = SKTexture(image: b!)
        birdTextureB.filteringMode = .linear
        
        // 2種類のテクスチャを交互に変更するアニメーションを作成
        let texuresAnimation = SKAction.animate(with: [birdTextureA, birdTextureB], timePerFrame: 0.2)
        let flap = SKAction.repeatForever(texuresAnimation)
        
        // スプライトを作成
        bird = SKSpriteNode(texture: birdTextureA)
        bird.position = CGPoint(x: self.frame.size.width / 2 - 10, y:self.frame.size.height * 0.5)
        
        let moveUp = SKAction.moveBy(x: 0, y: 50, duration: 1.5)
        let moveDown = SKAction.moveBy(x: 0, y: -50, duration: 1.5)
        let repeatUpDown = SKAction.repeatForever(SKAction.sequence([moveUp, moveDown]))
        
        // アニメーションを設定
        bird.run(flap)
        bird.run(repeatUpDown)
        
        // スプライトを追加する
        addChild(bird)
    }
    
}

