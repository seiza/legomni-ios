//
//  Legomni.h
//  Legomni
//
//  Created by Jacques COUVREUR on 23.05.12.
//  Copyright (c) 2012 me.couvreur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Legomni : NSObject

@property (strong, nonatomic) NSMutableArray* series;

- (int) differentFiguresCount;
- (int) doubleCount;
- (NSArray*) figuresToPush;

@end
