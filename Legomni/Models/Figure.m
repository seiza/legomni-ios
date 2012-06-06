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

- (NSString*) figureCode {
    return [NSString stringWithFormat:@"%d-%d", self.serie, self.index];
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

// {"count":3,"created_at":"2012-06-06T06:12:33Z","figure_code":"7-3","first_at":null,"give":2,"id":1,"updated_at":"2012-06-06T06:12:33Z","user_id":1,"wanted":1}
- (NSDictionary*) toJSON {
    NSMutableDictionary* json = [NSMutableDictionary dictionaryWithCapacity:0];
    // {"":3,"":"2012-06-06T06:12:33Z","":"7-3","":null,"":2,"":1,"":"2012-06-06T06:12:33Z","":1,"":1}
    [json setValue:[self figureCode] forKey:@"figure_code"];
    [json setValue:[NSNumber numberWithInt:self.quantity] forKey:@"count"];
    
//    [json setValue: forKey:@"id"];
//    [json setValue: forKey:@"user_id"];
//    [json setValue: forKey:@"give"];
//    [json setValue: forKey:@"wanted"];
//    [json setValue: forKey:@"created_at"];
//    [json setValue: forKey:@"first_at"];
//    [json setValue: forKey:@"updated_at"];
    return json;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        // aString = [[aDecoder decodeObjectForKey:@"aStringkey"] retain];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    // add [super encodeWithCoder:encoder] if the superclass implements NSCoding
    [encoder encodeObject:[self figureCode] forKey:@"figure_code"];
    [encoder encodeInt:self.quantity forKey:@"count"];
}

@end
