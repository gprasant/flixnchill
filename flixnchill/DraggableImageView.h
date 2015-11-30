//
//  DraggableImageView.h
//  tinder
//
//  Created by Prasanth Guruprasad on 11/19/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PotentialMatch.h"

@interface DraggableImageView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *taglineLabel;

@property (strong, nonatomic) PotentialMatch *currentMatch;
@property (strong, nonatomic) PotentialMatch *nextMatch;
@property (strong, nonatomic) NSMutableArray *matchCandidatesArray;

-(void) reset;
-(void) swipeRight;
-(void) swipeLeft;
-(void) bindWithNextMatch;
@end
