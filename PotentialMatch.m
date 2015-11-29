//
//  PotentialMatch.m
//  flixnchill
//
//  Created by Prasanth Guruprasad on 11/28/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "PotentialMatch.h"

@implementation PotentialMatch

-(id) initFromDictionary:(NSDictionary *)dictionary {
    if(self = [super init]) {
        self.name = dictionary[@"Name"];
        self.sex = dictionary[@"Sex"];
        self.age = dictionary[@"Age"];
        self.tagline = dictionary[@"Tagline"];
        self.photoUrlString = dictionary[@"Photo"];
    }
    return self;
}

@end
