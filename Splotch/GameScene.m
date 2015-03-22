//
//  GameScene.m
//  Splotch
//
//  Created by Andrew Robinson on 3/20/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "GameScene.h"
#import "HeroSprite.h"

@interface GameScene ()

@property (strong, nonatomic) SKSpriteNode *hero;

@property BOOL canSwipeLeft;
@property BOOL canSwipeRight;

@end

@implementation GameScene

#pragma mark - Init

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
    self.hero = [HeroSprite heroSprite];
    self.hero.position = CGPointMake(self.size.width/2, self.size.height/4);
    [self addChild:self.hero];
    
    // Spawn walls
    SKSpriteNode *wallLeft = [self wallSprite];
    wallLeft.position = CGPointMake(0, self.size.height/4);
    wallLeft.physicsBody.categoryBitMask = wallColliderLeft;
    [self addChild:wallLeft];
    
    SKSpriteNode *wallRight = [self wallSprite];
    wallRight.position = CGPointMake(self.frame.size.width, self.size.height/4);
    wallRight.physicsBody.categoryBitMask = wallColliderRight;
    [self addChild:wallRight];
    
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
    
    // Can swipe either way on start
    self.canSwipeRight = YES;
    self.canSwipeLeft = YES;
    
//    self.physicsBody = [SKPhysicsBody ]
}

#pragma mark - Sprites

- (SKSpriteNode *)wallSprite {
    
    SKSpriteNode *wall = [SKSpriteNode spriteNodeWithColor:[SKColor cyanColor] size:CGSizeMake(40, 100)];
    wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.size];
    //    spriteWallRight.physicsBody.affectedByGravity = FALSE;
    wall.physicsBody.dynamic = NO;
    wall.physicsBody.collisionBitMask = wallColliderLeft | heroCollider | wallColliderRight;
    wall.physicsBody.contactTestBitMask = heroCollider;
    wall.physicsBody.restitution = 0;
    
    return wall;
}

#pragma mark - Collisions

- (void)didBeginContact:(SKPhysicsContact *)contact {
    
    if (contact.bodyA.categoryBitMask == heroCollider && contact.bodyB.categoryBitMask == wallColliderLeft) {
        NSLog(@"Collide on Left");
        self.canSwipeLeft = NO;
        self.canSwipeRight = YES;
    }
    
    if (contact.bodyA.categoryBitMask == heroCollider && contact.bodyB.categoryBitMask == wallColliderRight) {
        NSLog(@"Collide on Right");
        self.canSwipeRight = NO;
        self.canSwipeLeft = YES;
    }
    
}

#pragma mark - Swipes

- (void)swipeLeft {
//    NSLog(@"Did Swipe Left");
    
    if (self.canSwipeLeft) {
        [self.hero.physicsBody applyImpulse:CGVectorMake(-40, 0)];
        self.canSwipeLeft = NO;
    }
    
}

- (void)swipeRight {
//    NSLog(@"Did Swipe Right");
    
    if (self.canSwipeRight) {
        [self.hero.physicsBody applyImpulse:CGVectorMake(40, 0)];
        self.canSwipeRight = NO;
    }

}

#pragma mark - Update

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
