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
    wallColliderRight,
    wallColliderLeft
    
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
    SKSpriteNode *hero = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(40, 40)];
    
    hero.position = CGPointMake(self.size.width/2, self.size.height/4);
    hero.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hero.size];
//    hero.physicsBody.affectedByGravity = FALSE;
    hero.physicsBody.categoryBitMask = heroCollider;
    hero.physicsBody.collisionBitMask = heroCollider | wallColliderRight | wallColliderLeft;
    hero.physicsBody.contactTestBitMask = wallColliderRight | wallColliderLeft;
    hero.physicsBody.restitution = 0;
    
    self.hero = hero;
    [self addChild:hero];
    
    // Spawn walls
    SKSpriteNode *spriteWallLeft = [SKSpriteNode spriteNodeWithColor:[UIColor cyanColor] size:CGSizeMake(40, 100)];
    spriteWallLeft.position = CGPointMake(0, self.size.height/4);
    spriteWallLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:spriteWallLeft.size];
//    spriteWallLeft.physicsBody.affectedByGravity = FALSE;
    spriteWallLeft.physicsBody.dynamic = NO;
    spriteWallLeft.physicsBody.categoryBitMask = wallColliderLeft;
    spriteWallLeft.physicsBody.collisionBitMask = wallColliderRight | heroCollider;
    spriteWallLeft.physicsBody.contactTestBitMask = heroCollider;
    spriteWallLeft.physicsBody.restitution = 0;
    [self addChild:spriteWallLeft];
    
    SKSpriteNode *spriteWallRight = [SKSpriteNode spriteNodeWithColor:[UIColor cyanColor] size:CGSizeMake(40, 100)];
    spriteWallRight.position = CGPointMake(self.frame.size.width, self.size.height/4);
    spriteWallRight.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:spriteWallRight.size];
//    spriteWallRight.physicsBody.affectedByGravity = FALSE;
    spriteWallRight.physicsBody.dynamic = NO;
    spriteWallRight.physicsBody.categoryBitMask = wallColliderRight;
    spriteWallRight.physicsBody.collisionBitMask = wallColliderLeft | heroCollider;
    spriteWallRight.physicsBody.contactTestBitMask = heroCollider;
    spriteWallRight.physicsBody.restitution = 0;
    [self addChild:spriteWallRight];
    
    // Create Vortexes outside of walls
    SKFieldNode *vortexLeft = [SKFieldNode springField];
    vortexLeft.position = CGPointMake(-self.size.width+47, self.size.height/4);
    vortexLeft.enabled = YES;
    vortexLeft.strength = .3f;
    vortexLeft.region = [[SKRegion alloc] initWithSize:self.frame.size];
    [self addChild:vortexLeft];
    
    SKFieldNode *vortexRight = [SKFieldNode springField];
    vortexRight.position = CGPointMake((self.size.width*2)-47, self.size.height/4);
    vortexRight.enabled = YES;
    vortexRight.strength = .3f;
    vortexRight.region = [[SKRegion alloc] initWithSize:self.frame.size];
    [self addChild:vortexRight];
    
//    self.physicsBody = [SKPhysicsBody ]
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    
    if (contact.bodyA.categoryBitMask == heroCollider && contact.bodyB.categoryBitMask == wallColliderLeft) {
        NSLog(@"Collide on Left");
    }
    
    if (contact.bodyA.categoryBitMask == heroCollider && contact.bodyB.categoryBitMask == wallColliderRight) {
        NSLog(@"Collide on Right");
    }
    
}

- (void)swipeLeft {
//    NSLog(@"Did Swipe Left");
    
    [self.hero.physicsBody applyImpulse:CGVectorMake(-40, 0)];
    
}

- (void)swipeRight {
//    NSLog(@"Did Swipe Right");
    
    [self.hero.physicsBody applyImpulse:CGVectorMake(40, 0)];

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
