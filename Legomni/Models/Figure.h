//
//  Figure.h
//  Legomni
//
//  Created by Jacques COUVREUR on 23.05.12.
//  Copyright (c) 2012 me.couvreur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Figure : NSObject

@property(strong, nonatomic) NSString* code;
@property(strong, nonatomic) NSString* name;
@property(strong, nonatomic) NSString* url;
@property(strong, nonatomic) NSString* slogan;
@property(strong, nonatomic) NSString* detail;
@property(nonatomic) int index;
@property(nonatomic) int serie;
@property(nonatomic) int strength;
@property(nonatomic) int creativity;
@property(nonatomic) int speed;
@property(nonatomic) int quantity;

- (id)initWithCode:(NSString*)c andSerie:(int)s;
- (NSString*) photoName;

@end
