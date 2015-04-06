//
//  FunnelWall.m
//  Splotch
//
//  Created by Andrew Robinson on 4/3/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "FunnelWall.h"
#import "SectionNode.h"
#import "GameScene.h"
#import "Stats.h"

@implementation FunnelWall

+ (id)easyWall {
    
    FunnelWall *leftFunnel = [self generateSprite];
    leftFunnel.position = CGPointMake([Stats instance].screenSize.width/2 - 30, 0);
    leftFunnel.physicsBody.categoryBitMask = wallColliderLeft;
    
    FunnelWall *rightFunnel = [self generateSprite];
    rightFunnel.position = CGPointMake([Stats instance].screenSize.width/2 + 30, 40);
    rightFunnel.physicsBody.categoryBitMask = wallColliderRight;
    
    SectionNode *blank = [SectionNode blankWithHeight:rightFunnel.size.height + 40];
    [blank addChild:leftFunnel];
    [blank addChild:rightFunnel];
    
    return blank;
    
}

+ (FunnelWall *)generateSprite {
    
    FunnelWall *wall = [FunnelWall spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(20, 400)];
    
    wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.size];
    wall.physicsBody.dynamic = NO;
    wall.physicsBody.collisionBitMask = wallColliderLeft | heroCollider | wallColliderRight;
    wall.physicsBody.contactTestBitMask = heroCollider;
    wall.physicsBody.restitution = 0;
    
    return wall;
    
}

@end
