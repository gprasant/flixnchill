//
//  MessageCell.m
//  flixnchill
//
//  Created by Prasanth Guruprasad on 12/3/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (void)awakeFromNib {
    // Initialization code
    self.myMessageLabel.clipsToBounds = self.otherPersonMessageLabel.clipsToBounds = YES;
    self.myMessageLabel.layer.cornerRadius = self.otherPersonMessageLabel.layer.cornerRadius = 13.0f;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
