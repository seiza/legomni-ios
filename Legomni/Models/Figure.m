//
//  Figure.m
//  Legomni
//
//  Created by Jacques COUVREUR on 23.05.12.
//  Copyright (c) 2012 me.couvreur. All rights reserved.
//

#import "Figure.h"

#define STORE_KEY_FIGURE_QUANTITY       @"STORE_KEY_FIGURE_QUANTITY"


@implementation Figure

@synthesize code;
@synthesize name;
@synthesize url;
@synthesize slogan;
@synthesize detail;
@synthesize index, serie, strength, creativity, speed, quantity;


- (NSString*) figureID {
    return [NSString stringWithFormat:@"s%d-%@", self.serie, self.code];
}

- (void)load {
    NSDictionary* storedData = [[NSUserDefaults standardUserDefaults] objectForKey:[self figureID]];
    if (storedData) {
        self.quantity = [[storedData objectForKey:STORE_KEY_FIGURE_QUANTITY] intValue];
    }
}

- (void)store {
    NSDictionary* dataToStore = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", self.quantity] forKey:STORE_KEY_FIGURE_QUANTITY];
	[[NSUserDefaults standardUserDefaults] setObject:dataToStore forKey:[self figureID]];
	BOOL written = [[NSUserDefaults standardUserDefaults] synchronize];
    if ( ! written) {
        @throw [NSException exceptionWithName:@"StoreException" reason:@"Unable to store Figure." userInfo:nil];
    }
}


- (id)initWithCode:(NSString*)c andSerie:(int)s {
    self = [super init];
    if (self) {
        self.code = c;
        self.serie = s;
        
        NSString* figureFile = [[NSBundle mainBundle]pathForResource:c ofType:@"plist"];
        NSDictionary* properties = [NSDictionary dictionaryWithContentsOfFile:figureFile];
        
        self.name       = [properties objectForKey:@"Name"];
        if (self.name) {
            self.url        = [properties objectForKey:@"URL"];
            self.slogan     = [properties objectForKey:@"Slogan"];
            self.detail     = [properties objectForKey:@"Description"];
            
            self.index      = [[properties objectForKey:@"Index"] intValue];
            self.strength   = [[properties objectForKey:@"SkillStrength"] intValue];
            self.creativity = [[properties objectForKey:@"SkillCreativity"] intValue];
            self.speed      = [[properties objectForKey:@"SkillSpeed"] intValue];
        } else {
            self.name = [NSString stringWithFormat:@"<%@>", c];
        }
        [self load];
    }
    return self;
}

- (NSString*) photoName {
    return [NSString stringWithFormat:@"%@.jpg", self.code];    
}

- (void)setQuantity:(int)q {
    quantity = q;
    [self store];
}


@end
