//
//  PubNubClient.m
//  flixnchill
//
//  Created by Prasanth Guruprasad on 12/3/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "PubNubClient.h"
#import <PubNub/PubNub.h>

@interface PubNubClient () <PNObjectEventListener>

@property (strong, nonatomic) PubNub *client;

@end

@implementation PubNubClient


+ (PubNubClient *) sharedInstance {
    static PubNubClient* _instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        PNConfiguration *config = [PNConfiguration configurationWithPublishKey:@"demo" subscribeKey:@"demo"];
        _instance = [PubNubClient clientWithConfiguration:config];
        [_instance addListener: _instance];
        [_instance subscribeToChannels:@[@"my_channel"] withPresence:YES];
    });
    return _instance;
}

- (void)client:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {
    
    // Handle new message stored in message.data.message
    if (message.data.actualChannel) {
        
        // Message has been received on channel group stored in
        // message.data.subscribedChannel
    }
    else {
        
        // Message has been received on channel stored in
        // message.data.subscribedChannel
    }
    NSLog(@"Received message: %@ on channel %@ at %@", message.data.message,
          message.data.subscribedChannel, message.data.timetoken);
}



@end
