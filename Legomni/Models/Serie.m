//
//  Serie.m
//  Legomni
//
//  Created by Jacques COUVREUR on 23.05.12.
//  Copyright (c) 2012 me.couvreur. All rights reserved.
//

#import "Serie.h"
#import "Figure.h"

@implementation Serie

@synthesize index;
@synthesize figures;

- (id)initWithIndex:(int)i {
    self = [super init];
    if (self) {
        self.index = i;
        self.figures = [NSMutableArray array];
        
        NSString* figureNamesFile = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%d", i] ofType:@"txt"];
        NSString* fileContents = [NSString stringWithContentsOfFile:figureNamesFile encoding:NSUTF8StringEncoding error:nil];
        NSArray* figureNames = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        for (NSString* name in figureNames) {
            Figure* figure = [[Figure alloc] initWithCode:name andSerie:i];
            [figures addObject:figure];
        }
        
        NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES];
        NSArray* sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        self.figures = [NSMutableArray arrayWithArray:[self.figures sortedArrayUsingDescriptors:sortDescriptors]];
    }
    return self;
}


- (int) differentFiguresCount {
    int count = 0;
    for (Figure* f in self.figures) {
        if (f.quantity > 0) ++count;
    }
    return count;
}

- (int) doubleCount {
    int count = 0;
    for (Figure* f in self.figures) {
        if (f.quantity > 1) count += f.quantity - 1;
    }
    return count;
}

@end
