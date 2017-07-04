//
//  SpriteNode.swift
//  GameFrameworkv4
//
//  Created by cadet on 29/06/2017.
//  Copyright © 2017 cadet. All rights reserved.
//

import SpriteKit

class SpriteNode: SKSpriteNode, GameSprite
{
    //Included to conform to GameSprite protocol
    var gameSpriteName : String
    var textureAtlas: SKTextureAtlas

    init(name: String, texture: SKTexture?, size: CGSize)
    {
        print("SpriteNode: init")
        gameSpriteName = name
        textureAtlas = SKTextureAtlas()
        super.init(texture: texture, color: .white, size: size)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onTap()
    {
        print("SpriteNode.onTap()")
        self.xScale = 4
        self.yScale = 4
        
        //need to send message to GKEntity = Soldier
    }
}
