//
//  GameViewController.h
//  Splotch
//

//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface GameViewController : UIViewController

- (void)resetViewAndScene;
- (SKScene*)resetSelf;

-(id)init;
+(GameViewController*)instance;

@end
