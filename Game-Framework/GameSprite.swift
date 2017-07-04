//
//  GameSprite.swift
//  GameFramework
//
//  Created by cadet on 26/06/2017.
//  Copyright © 2017 cadet. All rights reserved.
//

import SpriteKit


protocol GameSprite
{
    var gameSpriteName : String { get set }
    var textureAtlas: SKTextureAtlas { get set }
    
    func onTap()
}
