//
//  ChatViewController.h
//  flixnchill
//
//  Created by Prasanth Guruprasad on 12/2/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PotentialMatch.h"

@interface ChatViewController : UIViewController

@property (strong, nonatomic) PotentialMatch *chatWith;
@property (strong, nonatomic) NSArray *movies;

@property (assign, nonatomic) int randOne;
@property (assign, nonatomic) int randTwo;
@property (assign, nonatomic) int randThree;
@end
