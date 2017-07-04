//
//  Ground.swift
//  Game Framework v2
//
//  Created by cadet on 22/06/2017.
//  Copyright © 2017 cadet. All rights reserved.
//

import SpriteKit


class Ground: SKSpriteNode
{
    
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named:"Ground.atlas")
    var groundTexture: SKTexture?
    
    var loopWidth = CGFloat()
    var loopCount = CGFloat(1)
    
    func spawn (parentNode:SKNode, position:CGPoint, size: CGSize)
    {
        parentNode.addChild(self)
        self.size = size
        self.position = position
        
        //Use a non-default anchor point.  By positioning the ground by its top left corner,
        //we can place it just slightly above the bottom of the screen size.
        self.anchorPoint = CGPoint(x:0,y:1)
        
        //Default to the base texture
        if groundTexture == nil
        {
            groundTexture = textureAtlas.textureNamed("ground_tile.png")
        }
        
        //Create child nodes to repeat the texture
        createChildren()
        
        //Draw an edge physics body along the top of the ground node.
        //Note: physics body positions are relative to their nodes.
        //The top left of the node is X: 0, Y: 0, given our anchor point
        //The top right of the node is X: size.width, y: 0
        let pointTopRight = CGPoint(x: size.width, y: 0)
        self.physicsBody = SKPhysicsBody(edgeFrom: CGPoint.zero, to: pointTopRight)
        self.physicsBody?.affectedByGravity = false
    }
    
    // Build child nodes to repeat he ground texture
    func createChildren()
    {
        // First, make sure we have a groundTexture value
        if let texture = groundTexture
        {
            var tileCount:CGFloat = 0
            let textureSize = texture.size()
            
            //Resize the tiles at half the size of their texture for retina sharpness
            let tileSize = CGSize (width: textureSize.width / 2, height: textureSize.height / 2)
            
            //Build the nodes across entire ground width
            while tileCount * tileSize.width < self.size.width
            {
                let tileNode = SKSpriteNode(texture: texture)
                tileNode.size = tileSize
                tileNode.position.x = tileCount * tileSize.width
                
                //Position child nodes by their upper left corner
                tileNode.anchorPoint = CGPoint(x:0, y:1)
                
                //Add the child texture to the ground node
                self.addChild(tileNode)
                
                tileCount += 1
            }
            
            //Find the width of one-third of the children nodes to repeat the ground noce
            loopWidth = tileSize.width * floor(tileCount / 3)
        }
    }
    
    func checkForReposition(playerProgress:CGFloat)
    {
        //The ground needs to jump forward every time the player has moved this distance
        let groundJumpPosition = loopWidth * loopCount
        
        if playerProgress >= groundJumpPosition
        {
            //The player has moved past the jump position!
            //Move the ground forward
            self.position.x += loopWidth
            
            loopCount += 1
        }
    }
    
}
