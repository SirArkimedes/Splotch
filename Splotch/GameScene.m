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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(40, 40)];
        
//        sprite.xScale = 0.5;
//        sprite.yScale = 0.5;
        sprite.position = location;
        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
//        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
