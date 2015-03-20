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
    
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(40, 40)];
    
    sprite.position = CGPointMake(self.size.width/2, self.size.height/4);
    
    [self addChild:sprite];
    
    // Spawn walls
    SKSpriteNode *spriteWall = [SKSpriteNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(40, 100)];
    spriteWall.position = CGPointMake(0, self.size.height/4);
    [self addChild:spriteWall];
    
    SKSpriteNode *spriteWall2 = [SKSpriteNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(40, 100)];
    spriteWall2.position = CGPointMake(self.frame.size.width, self.size.height/4);
    [self addChild:spriteWall2];
    
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
