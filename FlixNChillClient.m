//
//  FlixNChillClient.m
//  flixnchill
//
//  Created by Prasanth Guruprasad on 11/28/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "FlixNChillClient.h"
#import "PFQuery.h"

@interface FlixNChillClient()

@property (strong, nonatomic) FlixNChillClient *sharedInstance;

@end

@implementation FlixNChillClient

+ (FlixNChillClient *) sharedInstance {
    static FlixNChillClient *instance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[FlixNChillClient alloc] init];
        }
    });
    return instance;
}

- (void) getMatchCandidatesWithParams:(NSDictionary *)dictionary
                           completion: (void (^)(NSArray *candidates, NSError *error))completion {
    PFQuery *query = [PFQuery queryWithClassName:@"PotentialMatches"];
    [query whereKey:@"Sex" equalTo:@"F"];
    query.limit = 10;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            completion(nil, error);
        } else {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d matches.", objects.count);
            // Do something with the found objects
            completion(objects, nil);
        }
    }];
}

@end
