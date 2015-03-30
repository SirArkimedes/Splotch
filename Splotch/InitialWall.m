//
//  InitialWall.m
//  Splotch
//
//  Created by Andrew Robinson on 3/30/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "InitialWall.h"
#import "GameScene.h"
#import "SectionNode.h"

@implementation InitialWall

+ (instancetype)initialWallWithBlankHeight:(CGFloat)height {
    
    SectionNode *blank = [SectionNode blankWithHeight:height];
    
    InitialWall *leftWall = [self generateSprite];
    leftWall.position = CGPointMake(0, blank.size.height/2);
    leftWall.physicsBody.categoryBitMask = wallColliderLeft;
    [blank addChild:leftWall];
    
    InitialWall *rightWall = [self generateSprite];
    rightWall.position = CGPointMake(blank.size.width, blank.size.height/2);
    rightWall.physicsBody.categoryBitMask = wallColliderRight;
    [blank addChild:rightWall];
    
    return blank;
    
}

+ (InitialWall *)generateSprite {
    
    InitialWall *wall = [InitialWall spriteNodeWithColor:[SKColor cyanColor] size:CGSizeMake(40, 100)];
    
    wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.size];
    wall.physicsBody.dynamic = NO;
    wall.physicsBody.collisionBitMask = wallColliderLeft | heroCollider | wallColliderRight;
    wall.physicsBody.contactTestBitMask = heroCollider;
    wall.physicsBody.restitution = 0;
    
    return wall;
    
}

@end
