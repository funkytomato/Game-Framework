//
//  ParallaxBackground.swift
//  Game Framework v2
//
//  Created by cadet on 22/06/2017.
//  Copyright © 2017 cadet. All rights reserved.
//

import SpriteKit


class ParallaxBackground: SKSpriteNode
{
    
    //movementMultiplier will store a float from 0-1 to indicate how fast the
    //ParallaxBackground should move past.
    //0 is full adjustment, no movement as the world goes past
    //1 is no adjustment, ParallaxBackground passes at normal speed
    var movementMultiplier = CGFloat(0)
    
    //jumpAdjustment will store how many points of x position this ParallaxBackground
    //has jumped forward, useful for calculating future seamless jump points.
    var jumpAdjustment = CGFloat(0)
    
    //A constant for ParallaxBackground node size
    let ParallaxBackgroundSize = CGSize(width:1000, height: 650)
    
    func spawn (parentNode:SKNode, imageName:String,
                zPosition:CGFloat, alpha: CGFloat, movementMultiplier: CGFloat)
    {
        //Position from the bottom left
        self.anchorPoint = CGPoint.zero
        
        //Start ParallaxBackgrounds at the top of the ground (y:30)
        self.position = CGPoint(x:0,y:30)
        //self.position = CGPoint(x:0,y:0)
        //self.position = CGPoint(x: size.width/2, y: size.height/2)

        //Control the order of the ParallaxBackgrounds with zPosition
        self.zPosition = zPosition
        
        //Set the alpha value of the background
        self.alpha = alpha
        
        //Store the movement multiplier
        self.movementMultiplier = movementMultiplier
        
        //Add the ParallaxBackground to the parentNode
        parentNode.addChild(self)
        
        
        //Build three child node instances of the texture,
        //Looping from -1 to 1 so the ParallaxBackgrounds cover both 
        //forward and behind the player at position zero.
        //closed range operator: "..." includes both endpoints
        for i in -1...1
        {
            let newBGNode = SKSpriteNode(imageNamed: imageName)
            
            //Set the size for this node from constant
            newBGNode.size = ParallaxBackgroundSize
            
            //Position this ParallaxBackground node
            newBGNode.position = CGPoint(x: i * Int(ParallaxBackgroundSize.width), y:0)
            
            //Position from the bottom left
            newBGNode.anchorPoint = CGPoint.zero
            
            //Add the node to the ParallaxBackground
            self.addChild(newBGNode)
        }
    }
    
    //We will call updatePosition every frame to reposition the ParallaxBackground
    func updatePosition(playerProgress:CGFloat)
    {
        //Calculate a position adjustment after loops and parallax multiplier
        let adjustedPosition = jumpAdjustment + playerProgress * (1 - movementMultiplier)
        
        //Check if we need to jump the ParallaxBackground forward
        if playerProgress - adjustedPosition > ParallaxBackgroundSize.width
        {
            jumpAdjustment += ParallaxBackgroundSize.width
        }
        
        //Adjust this ParallaxBackground forward as the world moves back so the ParallaxBackground appears slower
        self.position.x = adjustedPosition
    }
}
