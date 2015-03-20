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
    
//    self.physicsBody = [SKPhysicsBody bod]
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(5.f, 5.f)];
        
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
