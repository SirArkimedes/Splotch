//
//  GameScene.m
//  Splotch
//
//  Created by Andrew Robinson on 3/20/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "GameScene.h"

typedef enum {
    
    heroCollider,
    wallCollider
    
} collsions;

@interface GameScene ()

@property (strong, nonatomic) SKSpriteNode *hero;

@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    // Collisions
    self.physicsWorld.contactDelegate = self;
    
    self.physicsWorld.gravity = CGVectorMake(0,0);
    
    // Setup touches
    UISwipeGestureRecognizer * swipeLeft= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [view addGestureRecognizer:swipeLeft];
    // listen for swipes to the right
    UISwipeGestureRecognizer * swipeRight= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [view addGestureRecognizer:swipeRight];
    
    // Hero
    SKSpriteNode *hero = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(40, 40)];
    
    hero.position = CGPointMake(self.size.width/2, self.size.height/4);
    hero.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hero.size];
//    hero.physicsBody.affectedByGravity = FALSE;
    hero.physicsBody.categoryBitMask = heroCollider;
    hero.physicsBody.collisionBitMask = heroCollider | wallCollider;
    hero.physicsBody.contactTestBitMask = wallCollider | wallCollider;
    
    self.hero = hero;
    [self addChild:hero];
    
    // Spawn walls
    SKSpriteNode *spriteWallLeft = [SKSpriteNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(40, 100)];
    spriteWallLeft.position = CGPointMake(0, self.size.height/4);
    spriteWallLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:spriteWallLeft.size];
//    spriteWallLeft.physicsBody.affectedByGravity = FALSE;
    spriteWallLeft.physicsBody.dynamic = NO;
    spriteWallLeft.physicsBody.categoryBitMask = wallCollider;
    spriteWallLeft.physicsBody.collisionBitMask = wallCollider | heroCollider;
    spriteWallLeft.physicsBody.contactTestBitMask = heroCollider;
    [self addChild:spriteWallLeft];
    
    SKSpriteNode *spriteWallRight = [SKSpriteNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(40, 100)];
    spriteWallRight.position = CGPointMake(self.frame.size.width, self.size.height/4);
    spriteWallRight.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:spriteWallRight.size];
//    spriteWallRight.physicsBody.affectedByGravity = FALSE;
    spriteWallRight.physicsBody.dynamic = NO;
    spriteWallRight.physicsBody.categoryBitMask = wallCollider;
    spriteWallRight.physicsBody.collisionBitMask = wallCollider | heroCollider;
    spriteWallRight.physicsBody.contactTestBitMask = heroCollider;
    [self addChild:spriteWallRight];
    
//    self.physicsBody = [SKPhysicsBody ]
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    
    if (contact.bodyA.categoryBitMask == heroCollider || contact.bodyB.categoryBitMask == wallCollider) {
        NSLog(@"Something collided");
        
//        contact.bodyA.dynamic = NO;
//        self.hero.position = CGPointMake(self.hero.position.x, self.hero.position.y);
    }
    
}

- (void)swipeLeft {
    NSLog(@"Did Swipe Left");
    [self.hero.physicsBody applyImpulse:CGVectorMake(-10, 0)];
    
    if (self.hero.physicsBody.dynamic == NO) {
        self.hero.physicsBody.dynamic = YES;
    }
    
}

- (void)swipeRight {
    NSLog(@"Did Swipe Right");
    [self.hero.physicsBody applyImpulse:CGVectorMake(10, 0)];
    
    if (self.hero.physicsBody.dynamic == NO) {
        self.hero.physicsBody.dynamic = YES;
    }
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
