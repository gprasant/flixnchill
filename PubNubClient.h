//
//  PubNubClient.h
//  flixnchill
//
//  Created by Prasanth Guruprasad on 12/3/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PubNub/PubNub.h>

@interface PubNubClient : PubNub
+ (PubNubClient *)sharedInstance;
@end
