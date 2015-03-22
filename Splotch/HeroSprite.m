//
//  HeroSprite.m
//  Splotch
//
//  Created by Andrew Robinson on 3/21/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "HeroSprite.h"
#import "GameScene.h"

@implementation HeroSprite

+ (instancetype)heroSprite {
    HeroSprite *hero = [HeroSprite spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(40, 40)];
    
    hero.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hero.size];
    //    hero.physicsBody.affectedByGravity = FALSE;
    hero.physicsBody.categoryBitMask = heroCollider;
    hero.physicsBody.collisionBitMask = heroCollider | wallColliderRight | wallColliderLeft;
    hero.physicsBody.contactTestBitMask = wallColliderRight | wallColliderLeft;
    hero.physicsBody.restitution = 0;
    
    return hero;
}

@end
