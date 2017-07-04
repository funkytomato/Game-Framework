//
//  Constants.swift
//  Game Framework
//
//  Created by cadet on 20/06/2017.
//  Copyright © 2017 cadet. All rights reserved.
//

import Foundation

let meleeCost = 10
let rangedCost = 25
let heavyCost = 50

enum PhysicsCategory: UInt32
{
    case melee = 1
    case ranged = 2
    case bullet = 4
    case smoke = 8
    case explosion = 16
    case buildings = 32
    case ground = 64
}
