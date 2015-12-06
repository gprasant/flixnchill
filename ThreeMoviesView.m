//
//  ThreeMoviesView.m
//  flixnchill
//
//  Created by Greyson Gregory on 12/4/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "ThreeMoviesView.h"
#import "UIImageView+AFNetworking.h"
#include <stdlib.h>

@interface ThreeMoviesView()
@property (nonatomic, assign) CGPoint nopeButtonOneCenter;
@property (nonatomic, assign) CGPoint likeButtonOneCenter;
@property (nonatomic, assign) CGPoint moviePosterOneOriginalCenter;

@property (nonatomic, assign) CGPoint nopeButtonTwoCenter;
@property (nonatomic, assign) CGPoint likeButtonTwoCenter;
@property (nonatomic, assign) CGPoint moviePosterTwoOriginalCenter;

@property (nonatomic, assign) CGPoint nopeButtonThreeCenter;
@property (nonatomic, assign) CGPoint likeButtonThreeCenter;
@property (nonatomic, assign) CGPoint moviePosterThreeOriginalCenter;

@property (weak, nonatomic) IBOutlet UILabel *likeOne;
@property (weak, nonatomic) IBOutlet UILabel *likeTwo;
@property (weak, nonatomic) IBOutlet UILabel *likeThree;

@property (weak, nonatomic) IBOutlet UILabel *nopeOne;
@property (weak, nonatomic) IBOutlet UILabel *nopeTwo;
@property (weak, nonatomic) IBOutlet UILabel *nopeThree;
@end

@implementation ThreeMoviesView

- (void)awakeFromNib {
    self.nopeButtonOneCenter = self.nopeOneButton.center;
    self.likeButtonOneCenter = self.likeOneButton.center;
    self.moviePosterOneOriginalCenter = self.moviePosterOne.center;

    self.nopeButtonTwoCenter = self.nopeTwoButton.center;
    self.likeButtonTwoCenter = self.likeTwoButton.center;
    self.moviePosterTwoOriginalCenter = self.moviePosterTwo.center;

    self.nopeButtonThreeCenter = self.nopeThreeButton.center;
    self.likeButtonThreeCenter = self.likeThreeButton.center;
    self.moviePosterThreeOriginalCenter = self.MoviePosterThree.center;

    [self.doneButton addTarget:self.delegate action:@selector(onDoneTap) forControlEvents:UIControlEventTouchUpInside];
    [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [self.doneButton setBackgroundColor:[UIColor colorWithRed:(185/255.0) green:(9/255.0) blue:(11/255.0) alpha:1]];
    [self addSubview:self.doneButton];

}

- (void)setUpView:(NSArray*)movies withDraggableImageView:(DraggableImageView *)draggableImageView {
    self.moviePosterOne.center = self.moviePosterOneOriginalCenter;
    
    self.moviePosterTwo.center = self.moviePosterTwoOriginalCenter;

    self.MoviePosterThree.center = self.moviePosterThreeOriginalCenter;
    
    self.likeOne.alpha = 0;
    self.likeTwo.alpha = 0;
    self.likeThree.alpha = 0;
    
    self.nopeOne.alpha = 0;
    self.nopeTwo.alpha = 0;
    self.nopeThree.alpha = 0;
    
    int randOne = arc4random_uniform(19);
    int randTwo = arc4random_uniform(19);
    while (randOne == randTwo) {
        randTwo = arc4random_uniform(19);
    }
    int randThree = arc4random_uniform(19);
    while (randThree == randTwo || randThree == randTwo) {
        randThree = arc4random_uniform(19);
    }
    
    NSString *thumbnailString = movies[randOne][@"posters"][@"thumbnail"];
    NSURL *url = [NSURL URLWithString:thumbnailString];
    [self.moviePosterOne setImageWithURL:url];

    NSString *thumbnailTwoString = movies[randTwo][@"posters"][@"thumbnail"];
    NSURL *urlTwo = [NSURL URLWithString:thumbnailTwoString];
    [self.moviePosterTwo setImageWithURL:urlTwo];

    NSString *thumbnailThreeString = movies[randThree][@"posters"][@"thumbnail"];
    NSURL *urlThree = [NSURL URLWithString:thumbnailThreeString];
    [self.MoviePosterThree setImageWithURL:urlThree];

    self.matchName.text = draggableImageView.nameLabel.text;
    self.matchProfilePic.image = draggableImageView.profileImageView.image;
}

- (IBAction)onNopeTapOne:(id)sender {
    [UIView animateWithDuration:.3 animations:^{
        self.moviePosterOne.center = self.nopeButtonOneCenter;
        self.likeOne.alpha = 0;
    } completion:^(BOOL finished) {
        self.likeOne.alpha = 0;
        [UIView animateWithDuration:.3 animations:^{
            self.nopeOne.alpha = 1;
        }];
    }];

}

- (IBAction)onNopeTapTwo:(id)sender {
    [UIView animateWithDuration:.3 animations:^{
        self.moviePosterTwo.center = self.nopeButtonTwoCenter;
        self.likeTwo.alpha = 0;
    } completion:^(BOOL finished) {
        self.likeTwo.alpha = 0;
        [UIView animateWithDuration:.3 animations:^{
            self.nopeTwo.alpha = 1;
        }];

    }];

}

- (IBAction)onNopeTapThree:(id)sender {
    [UIView animateWithDuration:.3 animations:^{
        self.MoviePosterThree.center = self.nopeButtonThreeCenter;
        self.likeThree.alpha = 0;
    } completion:^(BOOL finished) {
        self.likeThree.alpha = 0;
        [UIView animateWithDuration:.3 animations:^{
            self.nopeThree.alpha = 1;
        }];

    }];

}

- (IBAction)onLikeTapOne:(id)sender {
    [UIView animateWithDuration:.3 animations:^{
        self.moviePosterOne.center = self.likeButtonOneCenter;
        self.nopeOne.alpha = 0;
    } completion:^(BOOL finished) {
        self.nopeOne.alpha = 0;
        [UIView animateWithDuration:.3 animations:^{
            self.likeOne.alpha = 1;
        }];

    }];
}

- (IBAction)onLikeTapTwo:(id)sender {
    [UIView animateWithDuration:.3 animations:^{
        self.moviePosterTwo.center = self.likeButtonTwoCenter;
        self.nopeTwo.alpha = 0;
    } completion:^(BOOL finished) {
        self.nopeTwo.alpha = 0;
        [UIView animateWithDuration:.3 animations:^{
            self.likeTwo.alpha = 1;
        }];

    }];

}

- (IBAction)onLikeTapThree:(id)sender {
    [UIView animateWithDuration:.3 animations:^{
        self.MoviePosterThree.center = self.likeButtonThreeCenter;
        self.nopeThree.alpha = 0;
    } completion:^(BOOL finished) {
        self.nopeThree.alpha = 0;
        [UIView animateWithDuration:.3 animations:^{
            self.likeThree.alpha = 1;
        }];

    }];

}

@end
