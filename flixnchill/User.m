//
//  User.m
//  flixnchill
//
//  Created by Alex Lester on 12/2/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "User.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>


@interface User()

@property (nonatomic, strong) NSDictionary *dictionary;

@end

@implementation User

- (id)init {
	self = [super init];
	self.matches = [[NSMutableArray alloc] init];
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



@end
