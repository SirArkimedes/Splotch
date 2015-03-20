//
//  GameScene.m
//  Splotch
//
//  Created by Andrew Robinson on 3/20/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
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
    hero.physicsBody.affectedByGravity = FALSE;
    
    [self addChild:hero];
    
    // Spawn walls
    SKSpriteNode *spriteWallLeft = [SKSpriteNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(40, 100)];
    spriteWallLeft.position = CGPointMake(0, self.size.height/4);
    spriteWallLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:spriteWallLeft.size];
    spriteWallLeft.physicsBody.affectedByGravity = FALSE;
    [self addChild:spriteWallLeft];
    
    SKSpriteNode *spriteWallRight = [SKSpriteNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(40, 100)];
    spriteWallRight.position = CGPointMake(self.frame.size.width, self.size.height/4);
    spriteWallRight.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:spriteWallRight.size];
    spriteWallRight.physicsBody.affectedByGravity = FALSE;
    [self addChild:spriteWallRight];
    
//    self.physicsBody = [SKPhysicsBody ]
}

- (void)swipeLeft {
    NSLog(@"Did Swipe Left");
}

- (void)swipeRight {
    NSLog(@"Did Swipe Right");
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
