//
//  PotentialMatch.h
//  flixnchill
//
//  Created by Prasanth Guruprasad on 11/28/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PotentialMatch : NSObject

// fields
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *sex;
@property (strong, nonatomic) NSNumber *age;
@property (strong, nonatomic) NSString *tagline;
@property (strong, nonatomic) NSString *photoUrlString;

//methods
-(id) initFromDictionary:(NSDictionary *)dictionary;

@end
