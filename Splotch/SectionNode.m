//
//  SectionNode.m
//  Splotch
//
//  Created by Andrew Robinson on 3/30/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "SectionNode.h"
#import "Stats.h"

@implementation SectionNode

+ (instancetype)blankWithHeight:(CGFloat)height {
    
    SectionNode *blankNode = [SectionNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake([Stats instance].screenSize.width, height)];
    
    return blankNode;
}

@end
