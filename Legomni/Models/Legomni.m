//
//  Legomni.m
//  Legomni
//
//  Created by Jacques COUVREUR on 23.05.12.
//  Copyright (c) 2012 me.couvreur. All rights reserved.
//

#import "Legomni.h"
#import "Serie.h"

@implementation Legomni

@synthesize series;

- (id)init {
    self = [super init];
    if (self) {
        self.series = [NSMutableArray array];
        
        for (int i = 5; i <= 7; ++i) {
            [series addObject:[[Serie alloc] initWithIndex:i]];
        }
    }
    return self;
}

@end
