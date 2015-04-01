//
//  StraightWall.m
//  Splotch
//
//  Created by Andrew Robinson on 4/1/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "StraightWall.h"
#import "SectionNode.h"
#import "GameScene.h"
#import "Stats.h"

@implementation StraightWall

+ (id)easyWall {
    
    StraightWall *leftWall = [self generateSprite];
    leftWall.position = CGPointMake(0, 0);
    leftWall.physicsBody.categoryBitMask = wallColliderLeft;
        
    StraightWall *rightWall = [self generateSprite];
    rightWall.position = CGPointMake([Stats instance].screenSize.width, 0);
    rightWall.physicsBody.categoryBitMask = wallColliderRight;
    
    SectionNode *blank = [SectionNode blankWithHeight:leftWall.size.height];
    [blank addChild:leftWall];
    [blank addChild:rightWall];
    
    return blank;
    
}

+ (StraightWall *)generateSprite {
    
    StraightWall *wall = [StraightWall spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(40, 400)];
    
    wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.size];
    wall.physicsBody.dynamic = NO;
    wall.physicsBody.collisionBitMask = wallColliderLeft | heroCollider | wallColliderRight;
    wall.physicsBody.contactTestBitMask = heroCollider;
    wall.physicsBody.restitution = 0;
    
    return wall;
    
}

@end
