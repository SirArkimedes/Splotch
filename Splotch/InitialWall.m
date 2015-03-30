//
//  InitialWall.m
//  Splotch
//
//  Created by Andrew Robinson on 3/30/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "InitialWall.h"
#import "GameScene.h"

@implementation InitialWall

+ (instancetype)initialWall {
    
    InitialWall *wall = [InitialWall spriteNodeWithColor:[SKColor cyanColor] size:CGSizeMake(40, 100)];
    
    wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.size];
    wall.physicsBody.dynamic = NO;
    wall.physicsBody.collisionBitMask = wallColliderLeft | heroCollider | wallColliderRight;
    wall.physicsBody.contactTestBitMask = heroCollider;
    wall.physicsBody.restitution = 0;
    
    return wall;
    
}

@end
