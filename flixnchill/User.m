//
//  User.m
//  flixnchill
//
//  Created by Alex Lester on 12/2/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "User.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>


@interface User()

@property (nonatomic, strong) NSDictionary *dictionary;

@end

@implementation User

- (id)init {
	self = [super init];
	self.matches = [[NSMutableArray alloc] init];
    [self addTestMatch]; // add taylor10 as a match always for testing chat
	return self;
}

static User *_currentUser = nil;

+ (void)setCurrentUser:(User *) user{
	_currentUser = user;
}

+ (User *)currentUser{
	return _currentUser;
}

+(void)logout{
	[User  setCurrentUser:nil];
	//TODO facebook logout logic
}

- (void)addMatch:(PotentialMatch *)match {
	[self.matches addObject:match];
}

-(void) addTestMatch {
    // Fetch ParseObject with Id for taylor10
    PFQuery *q = [PFQuery queryWithClassName:@"PotentialMatches"];
    [q getObjectInBackgroundWithId:@"NFCM2RTK2c"
                             block:^(PFObject * _Nullable object, NSError * _Nullable error) {
                                 if (!error) {
                                     PotentialMatch *taylor10 = [[PotentialMatch alloc] initFromPFObject:object];
                                     [self.matches addObject:taylor10];
                                 }
                             }];
}

@end
