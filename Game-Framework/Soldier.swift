//
//  GameEntity.swift
//  GameFramework
//
//  Created by cadet on 26/06/2017.
//  Copyright © 2017 cadet. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Soldier : GKEntity
{
    
    var spriteNode = SKSpriteNode()
    
    //Store the texture atlas as class wide properties
    var soldierAttack1Atlas: SKTextureAtlas?
    var soldierAttack2Atlas: SKTextureAtlas?
    var soldierAttack3Atlas: SKTextureAtlas?
    var soldierAttack4Atlas: SKTextureAtlas?
    var soldierHurtAtlas: SKTextureAtlas?
    var soldierIdleAtlas: SKTextureAtlas?
    var soldierJumpAtlas: SKTextureAtlas?
    var soldierRunAtlas: SKTextureAtlas?
    var soldierWalkAtlas: SKTextureAtlas?
    
    //The current playing animaton and all the animation sequences
    var currentAnimation = SKAction()
    var soldierAttack1Action = SKAction()
    var soldierAttack2Action = SKAction()
    var soldierAttack3Action = SKAction()
    var soldierAttack4Action = SKAction()
    var soldierHurtAction = SKAction()
    var soldierIdleAction = SKAction()
    var soldierJumpAction = SKAction()
    var soldierRunAction = SKAction()
    var soldierWalkAction = SKAction()
  

    init(entityManager: EntityManager, name: String)
    {
        print("init(entityManager) called")
 
        //let texture = SKTexture(imageNamed: "quirk\(team.rawValue)")
        //let spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size())
        //addComponent(spriteComponent)

        
        super.init()

        initaliseSpriteAtlas()
        
        //Create the SpriteComponent and add it to the Entity
        let texture = soldierIdleAtlas!.textureNamed("3_terrorist_3_Idle_000.png")
        let spriteComponent = SpriteComponent(entity: self, name: name, texture: texture, size: texture.size())
        spriteComponent.node.name = "soldier\(entityManager.soldierCount)"
        
        //NEED TO SET THE POSITION OF THE SPRITECOMPONENT = position
        //spriteComponent.node.position = position
        spriteComponent.node.zPosition = 1
        addComponent(spriteComponent)

        //Add SKSpriteNode to GameScene spriteEntites dictionary
        //Get pointer to gamescene
        //Call function to add sprite details (name: String, entity: GKEntity)
        //Do in GameScene?
        
        //Link to the entity's sprite
        spriteNode = SKSpriteNode()
        spriteNode = spriteComponent.node
    
        //Run the animation
        createAnimations()
        currentAnimation = soldierIdleAction
        spriteComponent.node.run(currentAnimation)

    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
 
    //Spawn function is used to place the sprite into the world.
    func spawn(parentNode:SKNode, position: CGPoint, size: CGSize)
    {
        print("spawn called")

        
        //Create the SpriteComponent and add it to the Entity
        let texture = soldierIdleAtlas!.textureNamed("3_terrorist_3_Idle_000.png")
        let name = "Soldier"
        let spriteComponent = SpriteComponent(entity: self, name: name, texture: texture, size: size)
        spriteComponent.node.name = "soldier"
        parentNode.addChild(spriteComponent.node)
        
        //NEED TO SET THE POSITION OF THE SPRITECOMPONENT = position
        spriteComponent.node.position = position
        spriteComponent.node.zPosition = 1
        spriteNode = spriteComponent.node
        addComponent(spriteComponent)

        //Run the animation
        createAnimations()
        currentAnimation = soldierIdleAction
        spriteComponent.node.run(currentAnimation)

        //this doesn't hold the location of sprite on screen - spriteComponent does!!!
        //addComponent(MoveComponent(maxSpeed: 150, maxAcceleration: 5, radius: Float(texture.size().width * 0.3), entityManager: entityManager))
        
    }
    
    func initaliseSpriteAtlas()
    {
        print("initaliseAlas called")
        
        soldierAttack1Atlas = SKTextureAtlas(named:"Soldier_Attack1")
        soldierAttack2Atlas = SKTextureAtlas(named:"Soldier_Attack2")
        soldierAttack3Atlas = SKTextureAtlas(named:"Soldier_Attack3")
        soldierAttack4Atlas = SKTextureAtlas(named:"Soldier_Attack4")
        soldierHurtAtlas = SKTextureAtlas(named:"Soldier_Hurt")
        soldierIdleAtlas = SKTextureAtlas(named:"Soldier_Idle")
        soldierJumpAtlas = SKTextureAtlas(named:"Soldier_Jump")
        soldierRunAtlas = SKTextureAtlas(named:"Soldier_Run")
        soldierWalkAtlas = SKTextureAtlas(named:"Soldier_Walk")
        
        currentAnimation = soldierIdleAction
    }
    
    //Build the animation sequences for the sprite
    func createAnimations()
    {
        createIdleAnimation()
    }
    
    func createIdleAnimation()
    {
        //Grab the frames from the texture atlas in an array
        //Note:  Check out the syntax explicitly declaring entity frames as an Array
        //SKTextures.  This is not strictly necessary, but it makes the intent of the
        //code more readable
        
        let soldierIdleFrames:[SKTexture] =
            [
                soldierIdleAtlas!.textureNamed("3_terrorist_3_Idle_000"),
                soldierIdleAtlas!.textureNamed("3_terrorist_3_Idle_001"),
                soldierIdleAtlas!.textureNamed("3_terrorist_3_Idle_002"),
                soldierIdleAtlas!.textureNamed("3_terrorist_3_Idle_003"),
                soldierIdleAtlas!.textureNamed("3_terrorist_3_Idle_004"),
                soldierIdleAtlas!.textureNamed("3_terrorist_3_Idle_005"),
                soldierIdleAtlas!.textureNamed("3_terrorist_3_Idle_006"),
                soldierIdleAtlas!.textureNamed("3_terrorist_3_Idle_007"),
            ]
 
        //Create a new SKAction to animate between the frames once
        let soldierIdleAnimation = SKAction.animate(with: soldierIdleFrames, timePerFrame: 0.14)
        
        //Create the SKACtion to run the sprite animation repeatedly
        soldierIdleAction = SKAction.repeatForever(soldierIdleAnimation)

    }
    
    func createWalkAnimation()
    {
        //Grab the frames from the texture atlas in an array
        //Note:  Check out the syntax explicitly declaring entity frames as an Array
        //SKTextures.  This is not strictly necessary, but it makes the intent of the
        //code more readable
        
        let soldierWalkFrames:[SKTexture] =
            [
                soldierWalkAtlas!.textureNamed("3_terrorist_3_Walk_000"),
                soldierWalkAtlas!.textureNamed("3_terrorist_3_Walk_001"),
                soldierWalkAtlas!.textureNamed("3_terrorist_3_Walk_002"),
                soldierWalkAtlas!.textureNamed("3_terrorist_3_Walk_003"),
                soldierWalkAtlas!.textureNamed("3_terrorist_3_Walk_004"),
                soldierWalkAtlas!.textureNamed("3_terrorist_3_Walk_005"),
                soldierWalkAtlas!.textureNamed("3_terrorist_3_Walk_006"),
                soldierWalkAtlas!.textureNamed("3_terrorist_3_Walk_007"),
                ]
        
        //Create a new SKAction to animate between the frames once
        let soldierWalkAnimation = SKAction.animate(with: soldierWalkFrames, timePerFrame: 0.14)
        
        //Create the SKACtion to run the sprite animation repeatedly
        soldierWalkAction = SKAction.repeatForever(soldierWalkAnimation)
        
    }
  
    func walk()
    {
        currentAnimation = soldierWalkAction
        spriteNode.run(currentAnimation)
    }
    
    func animate(action:SKAction)
    {
        currentAnimation = action
    }
}
