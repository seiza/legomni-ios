//
//  Serie.h
//  Legomni
//
//  Created by Jacques COUVREUR on 23.05.12.
//  Copyright (c) 2012 me.couvreur. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FIGURES_PER_SERIES      16

@interface Serie : NSObject

@property (nonatomic) int index;
@property (strong, nonatomic) NSMutableArray* figures;

- (id)initWithIndex:(int)index;

- (int) differentFiguresCount;
- (int) doubleCount;

@end
