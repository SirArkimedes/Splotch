//
//  GameScene.h
//  Splotch
//

//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate>

typedef enum {
    
    heroCollider,
    wallColliderRight,
    wallColliderLeft
    
} collsions;

@end
