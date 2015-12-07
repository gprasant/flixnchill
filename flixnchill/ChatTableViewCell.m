//
//  ChatTableViewCell.m
//  flixnchill
//
//  Created by Alex Lester on 12/2/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "ChatTableViewCell.h"

@implementation ChatTableViewCell


-(void)layoutSubviews
{
	self.matchImageView.layer.cornerRadius = self.matchImageView.frame.size.width / 2;
	self.matchImageView.clipsToBounds = YES;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
