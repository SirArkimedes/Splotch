//
//  Stats.m
//  Splotch
//
//  Created by Andrew Robinson on 3/30/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

#import "Stats.h"

static Stats *inst = nil;

@implementation Stats

- (id)init {
    if(self=[super init]) {
        self.screenSize = CGSizeMake(0, 0);
    }
    return self;
}

+ (Stats*)instance {
    if (!inst) {
        inst = [[Stats alloc] init];
    }
    return inst;
}

@end
