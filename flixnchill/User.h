//
//  User.h
//  flixnchill
//
//  Created by Alex Lester on 12/2/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PotentialMatch.h"

@interface User : NSObject

@property (strong, nonatomic) NSMutableArray *matches;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *friends;

- (void)addMatch:(PotentialMatch *)match;

+ (User *)currentUser;
+ (void)setCurrentUser:(User *)user;
+ (void)logout;

@end
