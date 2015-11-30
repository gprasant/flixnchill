//
//  FlixNChillClient.h
//  flixnchill
//
//  Created by Prasanth Guruprasad on 11/28/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlixNChillClient : NSObject

// Public methods
+ (FlixNChillClient *) sharedInstance;

// Private methods
- (void) getMatchCandidatesWithParams: (NSDictionary *) dictionary
                           completion: (void (^)(NSArray *candidates, NSError *error))completion;

@end
