//
//  GameScene.m
//  Splotch
//
//  Created by Andrew Robinson on 3/20/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "GameScene.h"
#import "HeroSprite.h"
#import "InitialWall.h"
#import "Stats.h"

static const CGFloat scrollSpeed = 150.f;

@interface GameScene ()

@property (strong, nonatomic) SKSpriteNode *hero;
@property (strong, nonatomic) SKSpriteNode *physicsNode;

@property BOOL canSwipeLeft;
@property BOOL canSwipeRight;

@property (strong, nonatomic) NSMutableArray *walls;

@end

@implementation GameScene

#pragma mark - Init

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    // Save the screen size
    [Stats instance].screenSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    
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
    
    // Physics Node
    SKSpriteNode *physics = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(self.frame.size.width, self.frame.size.height)];
    
    self.physicsNode = physics;
    [self addChild:self.physicsNode];
    
    // Initial walls
    SKSpriteNode *initialWall = [InitialWall initialWallWithBlankHeight:self.frame.size.height/2];
    [self.physicsNode addChild:initialWall];
    
    // Create Vortexes outside of walls
    SKFieldNode *vortexLeft = [SKFieldNode springField];
    vortexLeft.position = CGPointMake(-self.size.width+47, self.size.height/4);
    vortexLeft.enabled = YES;
    vortexLeft.strength = .3f;
    vortexLeft.region = [[SKRegion alloc] initWithSize:self.frame.size];
    [self.physicsNode addChild:vortexLeft];
    
    SKFieldNode *vortexRight = [SKFieldNode springField];
    vortexRight.position = CGPointMake((self.size.width*2)-47, self.size.height/4);
    vortexRight.enabled = YES;
    vortexRight.strength = .3f;
    vortexRight.region = [[SKRegion alloc] initWithSize:self.frame.size];
    [self.physicsNode addChild:vortexRight];
    
    // Can swipe either way on start
    self.canSwipeRight = YES;
    self.canSwipeLeft = YES;
    
//    self.physicsBody = [SKPhysicsBody ]
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

#pragma mark - Taps

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        // right
        if (center.x < location.x) {
            [self swipeRight];
        // left
        } else {
            [self swipeLeft];
        }
        
    }
}

#pragma mark - Update

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    // Move hero
    self.physicsNode.position = CGPointMake(self.physicsNode.position.x, self.physicsNode.position.y - (currentTime/10000));
//    NSLog(@"%@", NSStringFromCGPoint(self.hero.position));
    
}

@end
