//
//  PotentialMatch.m
//  flixnchill
//
//  Created by Prasanth Guruprasad on 11/28/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "PotentialMatch.h"
#import "PFObject.h"

@implementation PotentialMatch

-(id) initFromPFObject:(PFObject *)dictionary {
    if(self = [super init]) {
        self.age = dictionary[@"Age"];
        self.email = dictionary[@"Email"];
        self.firstName = dictionary[@"FirstName"];
        self.name = dictionary[@"Name"];
        self.photoUrlString = dictionary[@"Photo"];
        self.sex = dictionary[@"Sex"];
        self.tagline = dictionary[@"Tagline"];
    }
    return self;
}

@end
