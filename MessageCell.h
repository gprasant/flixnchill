//
//  MessageCell.h
//  flixnchill
//
//  Created by Prasanth Guruprasad on 12/3/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *otherPersonMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *myMessageLabel;

@end
