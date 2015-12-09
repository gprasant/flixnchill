//
//  MovieComparisonView.h
//  flixnchill
//
//  Created by Greyson Gregory on 12/8/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieComparisonView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *youLikedLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchLikedLabel;

@property (weak, nonatomic) IBOutlet UIImageView *youMovieOne;
@property (weak, nonatomic) IBOutlet UIImageView *youMovieTwo;
@property (weak, nonatomic) IBOutlet UIImageView *youMovieThree;

@property (weak, nonatomic) IBOutlet UIImageView *youMovieChoiceOne;
@property (weak, nonatomic) IBOutlet UIImageView *youMovieChoiceTwo;
@property (weak, nonatomic) IBOutlet UIImageView *youMovieChoiceThree;

@property (weak, nonatomic) IBOutlet UIImageView *matchMovieOne;
@property (weak, nonatomic) IBOutlet UIImageView *matchMovieTwo;
@property (weak, nonatomic) IBOutlet UIImageView *matchMovieThree;

@property (weak, nonatomic) IBOutlet UIImageView *matchMovieChoiceOne;
@property (weak, nonatomic) IBOutlet UIImageView *matchMovieChoiceTwo;
@property (weak, nonatomic) IBOutlet UIImageView *matchMovieChoiceThree;
@end
