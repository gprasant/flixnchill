//
//  MovieComparisonView.m
//  flixnchill
//
//  Created by Greyson Gregory on 12/8/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "MovieComparisonView.h"

@implementation MovieComparisonView

- (void)awakeFromNib {
    // Initialization code
    self.youLikedLabel.clipsToBounds = self.matchLikedLabel.clipsToBounds = YES;
    self.youLikedLabel.layer.cornerRadius = self.matchLikedLabel.layer.cornerRadius = 13.0f;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
