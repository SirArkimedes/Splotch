//
//  BlockingWall.m
//  Splotch
//
//  Created by Andrew Robinson on 4/15/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "BlockingWall.h"
#import "SectionNode.h"
#import "GameScene.h"
#import "Stats.h"

@implementation BlockingWall

+ (id)easyWall {
    
    BlockingWall *blocking = [self generateSprite];
    blocking.zRotation = 45;
    blocking.physicsBody.categoryBitMask = wallColliderMiddle;
    
    SectionNode *blank = [SectionNode blankWithHeight:blocking.size.height];
    blocking.position = CGPointMake(blank.size.width/2, 0);
    [blank addChild:blocking];
    
    return blank;
    
}

+ (BlockingWall *)generateSprite {
    
    BlockingWall *wall = [BlockingWall spriteNodeWithColor:[SKColor purpleColor] size:CGSizeMake(100, 40)];
    
    wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.size];
    wall.physicsBody.dynamic = NO;
    wall.physicsBody.collisionBitMask = wallColliderLeft | heroCollider | wallColliderRight;
    wall.physicsBody.contactTestBitMask = heroCollider;
    wall.physicsBody.restitution = 0;
    
    return wall;
    
}

@end
