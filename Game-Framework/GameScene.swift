//
//  GameScene.swift
//  Game-Framework
//
//  Created by cadet on 26/06/2017.
//  Copyright © 2017 cadet. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    //Game Camera
    var cameraNode : SKCameraNode!
    
    // Constants
    let margin = CGFloat(30)
    
    let initialPlayerPosition = CGPoint(x:150, y: 250)
    var playerProgress = CGFloat()
    
    //ParallaxBackgrounds and Parallex Views
    var ParallaxBackgrounds:[ParallaxBackground] = []
    
    // Entity-component system
    var entityManager: EntityManager!
    
    
    var sceneSprites: [String:GKEntity] = [:]
    //var sceneSprites : Dictionary<String, GKEntity>?
    //var sceneSprites : Dictionary<String, GKEntity>?
    
    
    // Update time
    private var lastUpdateTimeInterval : TimeInterval = 0
    
    override func didMove(to view: SKView)
    {
        
        print("scene size: \(size)")
        
        
        // Create entity manager
        entityManager = EntityManager(scene: self)
        
        // Add Background
        let Background = SKSpriteNode(imageNamed: "country-platform-back")
        Background.position = CGPoint(x: size.width/2, y: size.height/2)
        Background.xScale = 2
        Background.yScale = 2
        Background.zPosition = -20
        Background.alpha = 0.9
        self.addChild(Background)
        
        //createParallaxViews()
        
        // Create the entities
        // Entities get add to the world inside EntityManager
        
        //Create the solder and display in game scene
        let soldier = entityManager.spawnSoldier()
        
        
        // Create a pointer to the GKEntity
        
        let spriteName = soldier.component(ofType: SpriteComponent.self)?.node.gameSpriteName
        //let entityName = "Entity entityName"
        
        // declare a dictionary you can use the square brackets syntax([KeyType:ValueType])
        //var sceneSprites : [String:String]
        //        sceneSprites = Dictionary<spriteName: entityName>
        //        sceneSprites?.updateValue(soldier, forKey: name)
        
        
        // initialize a dictionary with a dictionary literal. A dictionary literal is a list of key-value pairs, separated by commas, surrounded by a pair of square brackets. A key-value pair is a combination of a key and a value separate by a colon(:).
        /*        var sceneSprites : [String: String] =
         [
         "One" : "One",
         "Two" : "Two"
         ]
         */
        
        // create empty dictionary using the empty dictionary literal ([:])
        //var sceneSprites: [String:GKEntity] = [:]
        sceneSprites[spriteName!] = soldier
        
        
        //Add camera to scene centered on soldier
        addCameraNode(nodeToAttach: (soldier.component(ofType: SpriteComponent.self)?.node.self)!)
        
        
    }
    
    func createParallaxViews()
    {
        //Instantiate ParallaxBackgrounds to the ParallaxBackground array
        //for i in 0...3
        for _ in 0...3
        {
            ParallaxBackgrounds.append(ParallaxBackground())
        }
        
        //Spawn the new ParallaxBackgrounds
        ParallaxBackgrounds[0].spawn(parentNode: self, imageName:"clouds1", zPosition: -5, alpha: 0.5, movementMultiplier: 0.75)
        ParallaxBackgrounds[1].spawn(parentNode: self, imageName:"sun", zPosition: -15, alpha: 0.8, movementMultiplier: 0.50)
        ParallaxBackgrounds[2].spawn(parentNode: self, imageName:"country-platform-forest", zPosition: -15, alpha: 0.4, movementMultiplier: 0.2)
        //ParallaxBackgrounds[3].spawn(parentNode: world, imageName:"ParallaxBackground-4", zPosition: -20, movementMultiplier: 0.1)
    }
    
    func addCameraNode(nodeToAttach: SKSpriteNode)
    {
        //Initialise and assign an instance of SKCameraNode
        cameraNode = SKCameraNode()
        
        //Set the camera's zoom scale
        cameraNode.setScale(0.50)
        
        //Set the scene's camera to reference cameraNode
        self.camera = cameraNode
        
        //Make the cameraNode a childElement of the scene itself
        self.addChild(cameraNode)
        
        //Position the camera on the gamescene
        cameraNode.position = CGPoint(x: size.width/2, y: size.height/2)

    }
    
    func touchDown(atPoint pos : CGPoint)
    {
    }
    
    func touchMoved(toPoint pos : CGPoint)
    {
    }
    
    func touchUp(atPoint pos : CGPoint)
    {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        print("touchesBegan started")
        //for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        guard let touch = touches.first else
        {
            return
        }
        
        //Find the location of the touch
        let touchLocation = touch.location(in: self)
        print("\(touchLocation)")
        
        //Locate the node at this location
        let nodeTouched = nodes(at: touchLocation)
        print (nodeTouched)
        
        if let gameSprite = nodeTouched.first as? GameSprite
        {
            for x in sceneSprites
            {
                // Unwrapping the optional using optional binding
                if let entity = sceneSprites[gameSprite.gameSpriteName]
                {
                    entity.component(ofType: SpriteComponent.self)?.node.onTap()
                }
            }
            
        }
        
        //Position the camera
        let firstTouch = touches.first
        let location = (firstTouch?.location(in: self))!
        cameraNode.position = location
        
        print ("finished touches began")
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func didSimulatePhysics()
    {
        /*
        //To find the correct position, subtract half of th scene size from the
        //player's position, adjusted fro any world scaling.
        //Multiply by -1 and you have the adjustment to keep our sprite centered
        let worldXPos = (soldier.component(ofType: SpriteComponent.self)?.node.self)!.spriteNode.position.x * self.xScale - (self.size.width/2))
        let worldYPos = (soldier.spriteNode.position.y * self.yScale - (self.size.height/2))
        
        let worldXPos = (size.width/2) - self.xScale
        let worldYPos = (size.height/2) - self.yScale
        self.position = CGPoint(x: worldXPos, y: worldYPos)
        //print ("didSimulatePhysics 2")
        */
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
        
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        
        entityManager.update(deltaTime)
    }
}
