//
//  EntityManager.swift
//  Game Framework
//
//  Created by cadet on 20/06/2017.
//  Copyright © 2017 cadet. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class EntityManager
{
    var entities = Set<GKEntity>()
    var toRemove = Set<GKEntity>()
    let scene: SKScene
    
    var soldierCount: Int = 0
    
    lazy var componentSystems: [GKComponentSystem] =
    {
        //Define the components of the ComponentSystem
        
        let spriteSystem = GKComponentSystem(componentClass: SpriteComponent.self)
        let moveSystem = GKComponentSystem(componentClass: MoveComponent.self)
//        let meleeSystem = GKComponentSystem(componentClass: MeleeComponent.self)
//        let weaponSystem = GKComponentSystem(componentClass: WeaponComponent.self)
//        let homebaseSystem = GKComponentSystem(componentClass: HomebaseComponent.self)
//        let aiSystem = GKComponentSystem(componentClass: AIComponent.self)
//        return [moveSystem, meleeSystem, weaponSystem, homebaseSystem, aiSystem]

        return [spriteSystem,moveSystem]
    }()
    
    init(scene: SKScene)
    {
        self.scene = scene
    }
    
    //Add a SpriteComponent Entity to the game world
    func add(_ entity: GKEntity)
    {
        entities.insert(entity)
        
        for componentSystem in componentSystems
        {
            componentSystem.addComponent(foundIn: entity)
        }
        
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node
        {
            scene.addChild(spriteNode)
        }
    }
    
    //Remove a SpriteComponent Entity from the game world
    func remove(_ entity: GKEntity)
    {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node
        {
            spriteNode.removeFromParent()
        }
        
        toRemove.insert(entity)
        entities.remove(entity)
    }
    
/*
    func getSpriteComponent(_ entity: GKEntity) -> SpriteComponent
    {
        let spriteNode : GameSprite?
        if let spriteNode = entity.component(ofType: SpriteComponent.self)
        {
            return spriteNode
        }
    }
  */  
/*
    func entitiesForTeam(_ team: Team) -> [GKEntity]
    {
        return entities.flatMap{entity in
            if let teamComponent = entity.component(ofType: TeamComponent.self)
            {
                if teamComponent.team == team
                {
                    return entity
                }
            }
            return nil
        }
    }
    
    func moveComponentsForTeam(_ team: Team) -> [MoveComponent]
    {
        let entities = entitiesForTeam(team)
        var moveComponents = [MoveComponent]()
        for entity in entities
        {
            if let moveComponent = entity.component(ofType: MoveComponent.self)
            {
                moveComponents.append(moveComponent)
            }
        }
        return moveComponents
    }   
    
    func HomebaseForTeam(_ team: Team) -> GKEntity?
    {
        for entity in entities
        {
            if let teamComponent = entity.component(ofType: TeamComponent.self),
                let _ = entity.component(ofType: HomebaseComponent.self)
            {
                if teamComponent.team == team
                {
                    return entity
                }
            }
        }
        return nil
    }
*/
    func update(_ deltaTime: CFTimeInterval)
    {
        for componentSystem in componentSystems
        {
            componentSystem.update(deltaTime: deltaTime)
        }
        
        for curRemove in toRemove
        {
            for componentSystem in componentSystems
            {
                componentSystem.removeComponent(foundIn: curRemove)
            }
        }
        toRemove.removeAll()
    }

    func spawnSoldier() -> GKEntity
    {
 /*       guard let teamEntity = HomebaseForTeam(team),
            let teamBaseComponent = teamEntity.component(ofType: HomebaseComponent.self),
            let teamSpriteComponent = teamEntity.component(ofType: SpriteComponent.self) else {
                return
        }
        
        if teamBaseComponent.coins < meleeCost
        {
            return
        }
        
        teamBaseComponent.coins -= meleeCost
        scene.run(SoundManager.sharedInstance.soundSpawn)
   */
        let name = "Soldier\(soldierCount)"
        let soldier = Soldier(entityManager: self, name: name)
        if let spriteComponent = soldier.component(ofType: SpriteComponent.self)
        {
            spriteComponent.node.position = CGPoint(x: CGFloat.random(min: scene.size.height * 0.25, max: scene.size.height * 0.75), y: CGFloat.random(min: scene.size.height * 0.25, max: scene.size.height * 0.75))
            spriteComponent.node.zPosition = 2
        }
        add(soldier)
        
        soldierCount += 1
        
        return soldier
    }
    
/*
    func spawnMelee(_ team: Team)
    {
        guard let teamEntity = HomebaseForTeam(team),
            let teamBaseComponent = teamEntity.component(ofType: HomebaseComponent.self),
            let teamSpriteComponent = teamEntity.component(ofType: SpriteComponent.self) else {
                return
        }
        
        if teamBaseComponent.coins < meleeCost
        {
            return
        }
        
        teamBaseComponent.coins -= meleeCost
        scene.run(SoundManager.sharedInstance.soundSpawn)
        
        let melee = Melee(team: team, entityManager: self)
        if let spriteComponent = melee.component(ofType: SpriteComponent.self)
        {
            spriteComponent.node.position = CGPoint(x: teamSpriteComponent.node.position.x, y: CGFloat.random(min: scene.size.height * 0.25, max: scene.size.height * 0.75))
            spriteComponent.node.zPosition = 2
        }
        add(melee)
    }
    
    
    func spawnRanged(_ team: Team)
    {
        guard let teamEntity = HomebaseForTeam(team),
            let HomebaseComponent = teamEntity.component(ofType: HomebaseComponent.self),
            let teamSpriteComponent = teamEntity.component(ofType: SpriteComponent.self) else {
                return
        }
        
        if HomebaseComponent.coins < rangedCost
        {
            return
        }
        
        HomebaseComponent.coins -= rangedCost
        scene.run(SoundManager.sharedInstance.soundSpawn)
        
        let ranged = Ranged(team: team, entityManager: self)
        if let spriteComponent = ranged.component(ofType: SpriteComponent.self)
        {
            spriteComponent.node.position = CGPoint(x: teamSpriteComponent.node.position.x, y: CGFloat.random(min: scene.size.height * 0.25, max: scene.size.height * 0.75))
            spriteComponent.node.zPosition = 2
        }
        add(ranged)
    }
    
    func spawnHeavy(_ team: Team)
    {
        guard let teamEntity = HomebaseForTeam(team),
            let HomebaseComponent = teamEntity.component(ofType: HomebaseComponent.self),
            let teamSpriteComponent = teamEntity.component(ofType: SpriteComponent.self) else {
                return
        }
        
        if HomebaseComponent.coins < heavyCost
        {
            return
        }
        
        HomebaseComponent.coins -= heavyCost
        scene.run(SoundManager.sharedInstance.soundSpawn)
        
        let heavy = Heavy(team: team, entityManager: self)
        if let spriteComponent = heavy.component(ofType: SpriteComponent.self)
        {
            spriteComponent.node.position = CGPoint(x: teamSpriteComponent.node.position.x, y: CGFloat.random(min: scene.size.height * 0.25, max: scene.size.height * 0.75))
            spriteComponent.node.zPosition = 2
        }
        add(heavy)
    }
    
    func spawnHomebase(_ team: Team)
    {
        guard let teamEntity = HomebaseForTeam(team),
            let HomebaseComponent = teamEntity.component(ofType: HomebaseComponent.self),
            let teamSpriteComponent = teamEntity.component(ofType: SpriteComponent.self) else {
                return
        }
        
        //if HomebaseComponent.coins < heavyCost
        //{
        //    return
        //}
        
        //HomebaseComponent.coins -= heavyCost
        //scene.run(SoundManager.sharedInstance.soundSpawn)
        
//        let homeBase = Homebase(team: team, entityManager: self)
  //      if let spriteComponent = homeBase.component(ofType: SpriteComponent.self)
  //      {
 //           spriteComponent.node.position = CGPoint(x: teamSpriteComponent.node.position.x, y: CGFloat.random(min: scene.size.height * 0.25, max: scene.size.height * 0.75))
 //           spriteComponent.node.zPosition = 2
  //      }
  //      add(homeBase)
    }
 */
}
