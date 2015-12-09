//
//  PotentialMatch.h
//  flixnchill
//
//  Created by Prasanth Guruprasad on 11/28/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFObject.h"

@interface PotentialMatch : NSObject

// fields
@property (strong, nonatomic) NSNumber *age;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *photoUrlString;
@property (strong, nonatomic) NSString *sex;
@property (strong, nonatomic) NSString *tagline;

@property (assign, nonatomic) int randOne;
@property (assign, nonatomic) int randTwo;
@property (assign, nonatomic) int randThree;

//methods
-(id) initFromPFObject:(PFObject *)dictionary;

@end
