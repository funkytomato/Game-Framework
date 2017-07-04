//
//  SpriteComponent.swift
//  Game Framework
//
//  Created by cadet on 20/06/2017.
//  Copyright © 2017 cadet. All rights reserved.
//

//Import SpriteKit and GameplayKit libraries
import SpriteKit
import GameplayKit


class SpriteComponent: GKComponent
{
    let node: SpriteNode
    
    //Basic initializer for the sprite node created using the passed in texture
    init (entity: GKEntity, name: String, texture: SKTexture, size: CGSize)
    {
        print("SpriteComponent: init")
        //let name = String("SpriteComponent Sprite")
        //node = SpriteNode(name: name!, texture: texture, size: size)
        node = SpriteNode(name: name, texture: texture, size: size)
        super.init()
    }
    
    //Required function to achieve compliance with the GKComponent
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onTap()
    {
        print ("SpriteComponent.onTap()")
        
    }

}
