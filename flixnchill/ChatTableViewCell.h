//
//  ChatTableViewCell.h
//  flixnchill
//
//  Created by Alex Lester on 12/2/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PotentialMatch.h"

@interface ChatTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *matchImageView;

@property (strong, nonatomic) PotentialMatch *match;

@end
