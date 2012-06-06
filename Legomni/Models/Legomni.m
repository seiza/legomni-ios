//
//  Legomni.m
//  Legomni
//
//  Created by Jacques COUVREUR on 23.05.12.
//  Copyright (c) 2012 me.couvreur. All rights reserved.
//

#import "Legomni.h"
#import "Serie.h"
#import "Figure.h"

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

- (int) differentFiguresCount {
    int count = 0;
    for (Serie* s in self.series) {
        count += [s differentFiguresCount];
    }
    return count;
}

- (int) doubleCount {
    int count = 0;
    for (Serie* s in self.series) {
        count += [s doubleCount];
    }
    return count;
}

- (NSArray*) figuresToPush {
    NSMutableArray* figures = [NSMutableArray array];
    for (Serie* s in self.series) {
        for (Figure* f in s.figures) {
            if (f.quantity > 0) {
                [figures addObject:f];
            }
        }
    }
    return figures;
}

@end
