//
//  SerieTests.m
//  Legomni
//
//  Created by Jacques COUVREUR on 29.05.12.
//  Copyright (c) 2012 me.couvreur. All rights reserved.
//

#import "SerieTests.h"
#import "Serie.h"
#import "Figure.h"

@implementation SerieTests

- (void) test_differentFiguresCount_and_doubleCount {
    Serie* serie = [[Serie alloc] initWithIndex:3];
    {
        Figure* f = [[Figure alloc] initWithCode:@"0" andSerie:3];
        [serie.figures addObject:f];
        f.quantity = 0;
        STAssertEquals([serie differentFiguresCount], 0, nil);
        STAssertEquals([serie doubleCount], 0, nil);
    }
    {
        Figure* f = [[Figure alloc] initWithCode:@"1" andSerie:3];
        [serie.figures addObject:f];
        f.quantity = 1;
        STAssertEquals([serie differentFiguresCount], 1, nil);
        STAssertEquals([serie doubleCount], 0, nil);
    }
    {
        Figure* f = [[Figure alloc] initWithCode:@"2" andSerie:3];
        [serie.figures addObject:f];
        f.quantity = 2;
        STAssertEquals([serie differentFiguresCount], 2, nil);
        STAssertEquals([serie doubleCount], 1, nil);
    }
}

@end
