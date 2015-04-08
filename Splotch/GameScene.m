//
//  GameScene.m
//  Splotch
//
//  Created by Andrew Robinson on 3/20/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "GameScene.h"
#import "HeroSprite.h"
#import "Stats.h"
#import "GameViewController.h"

#import "InitialWall.h"
#import "StraightWall.h"
#import "FunnelWall.h"

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
    
    // Initialize walls
    self.walls = [[NSMutableArray alloc] init];
    
    // Save the screen size
    [Stats instance].screenSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    
    // Collisions
    self.physicsWorld.contactDelegate = self;
    
    self.physicsWorld.gravity = CGVectorMake(0,0);
    
//    // Setup touches
//    UISwipeGestureRecognizer * swipeLeft= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft)];
//    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
//    [view addGestureRecognizer:swipeLeft];
//    // listen for swipes to the right
//    UISwipeGestureRecognizer * swipeRight= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight)];
//    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
//    [view addGestureRecognizer:swipeRight];
    
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
    [self.walls addObject:initialWall];
    
    SKSpriteNode *straightWall = [StraightWall easyWall];
    straightWall.position = CGPointMake(0, initialWall.size.height + straightWall.size.height/2);
    [self.physicsNode addChild:straightWall];
    [self.walls addObject:straightWall];
    
    // Create Vortexes outside of walls
    SKFieldNode *vortexLeft = [SKFieldNode springField];
    vortexLeft.position = CGPointMake(-self.size.width + 40, self.size.height/4);
    vortexLeft.enabled = YES;
    vortexLeft.strength = .2f;
    vortexLeft.region = [[SKRegion alloc] initWithSize:self.frame.size];
    [self addChild:vortexLeft];
    
    SKFieldNode *vortexRight = [SKFieldNode springField];
    vortexRight.position = CGPointMake((self.size.width*2) - 40, self.size.height/4);
    vortexRight.enabled = YES;
    vortexRight.strength = .2f;
    vortexRight.region = [[SKRegion alloc] initWithSize:self.frame.size];
    [self addChild:vortexRight];
    
    // Inverted vortex at the bottom of the screen
    SKFieldNode *vortexBottom = [SKFieldNode springField];
    vortexBottom.position = CGPointMake(self.size.width/2, (-self.size.height + 40));
    vortexBottom.enabled = YES;
    vortexBottom.strength = -.2f;
    vortexBottom.region = [[SKRegion alloc] initWithSize:self.frame.size];
    [self addChild:vortexBottom];
    
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
    
    if (contact.bodyA.categoryBitMask == heroCollider && contact.bodyB.categoryBitMask == wallColliderMiddle) {
        NSLog(@"Collide Middle");
        self.canSwipeRight = YES;
        self.canSwipeLeft = YES;
    }
    
}

#pragma mark - Swipes

- (void)swipeLeft {
//    NSLog(@"Did Swipe Left");
    
    if (self.canSwipeLeft) {
        [self.hero.physicsBody applyImpulse:CGVectorMake(-50, 0)];
        self.canSwipeLeft = NO;
    }
    
    if (self.canSwipeLeft && self.canSwipeRight) {
        [self.hero.physicsBody applyImpulse:CGVectorMake(50, 0)];
        self.canSwipeRight = NO;
        self.canSwipeLeft = NO;
    }
    
}

- (void)swipeRight {
//    NSLog(@"Did Swipe Right");
    
    if (self.canSwipeRight) {
        [self.hero.physicsBody applyImpulse:CGVectorMake(50, 0)];
        self.canSwipeRight = NO;
    }
    
    if (self.canSwipeLeft && self.canSwipeRight) {
        [self.hero.physicsBody applyImpulse:CGVectorMake(50, 0)];
        self.canSwipeRight = NO;
        self.canSwipeLeft = NO;
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
    
//    // Move hero
//    self.physicsNode.position = CGPointMake(self.physicsNode.position.x, self.physicsNode.position.y - (currentTime/100000));
    
    for (SKSpriteNode *child in [self.physicsNode children]) {
        child.position = CGPointMake(child.position.x, child.position.y - (currentTime/100000));
    }
    
    // Create endless walls
    NSMutableArray *offScreenWalls = nil;
    for (SKSpriteNode *wall in self.walls) {
//        CGPoint wallPosition = wall.position;
        CGFloat wallY = wall.position.y + wall.size.height/2;
        if (wallY < 0) {
            if (offScreenWalls == nil) {
                offScreenWalls = [NSMutableArray array];
            }
            [offScreenWalls addObject:wall];
        }
    }
    
    for (SKSpriteNode *wallToRemove in offScreenWalls) {
        [wallToRemove removeFromParent];
        [self.walls removeObject:wallToRemove];
        // for each removed obstacle, add a new one
        [self spawnNewWall];
    }
    
    // Check game over
    if (self.hero.position.x < 0 || self.hero.position.x > self.frame.size.width ||
        self.hero.position.y < 0 || self.hero.position.y > self.frame.size.height)
        [self gameOver];
    
//    NSLog(@"%@", NSStringFromCGPoint(self.hero.position));
    
}

#pragma mark - Helpers

- (void)spawnNewWall {
    
    SKSpriteNode *previousWall = [self.walls lastObject];
    CGFloat previousWallYPosition = previousWall.position.y;
//    if (!previousWall) {
//        // this is the first obstacle
//        previousWallYPosition = firstObstaclePosition;
//    }
    
    int ran = arc4random_uniform(2);
    
    SKSpriteNode *wall;
    switch (ran) {
        case 0:
            wall = [StraightWall easyWall];
            break;
        case 1:
            wall = [FunnelWall easyWall];
            break;

    }
    
    wall.position = CGPointMake(0, previousWallYPosition + wall.size.height + 10);
    
//    [obstacle setupRandomPosition];
    
    [self.physicsNode addChild:wall];
    [self.walls addObject:wall];
    
}

- (void)gameOver {
    // Create and configure the scene.
    SKScene *scene = [[GameViewController instance] resetSelf];
    scene.size = self.view.frame.size;
    
    // Present the scene.
    [self.view presentScene:scene];
}

@end
