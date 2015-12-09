//
//  ThreeMoviesView.m
//  flixnchill
//
//  Created by Greyson Gregory on 12/4/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "ThreeMoviesView.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailsView.h"
#include <stdlib.h>

@interface ThreeMoviesView()
@property (nonatomic, assign) CGPoint currentlyPanningOriginalCenter;
@property (nonatomic, assign) CGPoint currentlyPanningOriginalCenterTwo;
@property (nonatomic, assign) CGPoint currentlyPanningOriginalCenterThree;

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
    self.moviePosterThreeOriginalCenter = self.moviePosterThree.center;

    [self.doneButton addTarget:self.delegate action:@selector(onDoneTap) forControlEvents:UIControlEventTouchUpInside];
    [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [self.doneButton setBackgroundColor:[UIColor colorWithRed:(185/255.0) green:(9/255.0) blue:(11/255.0) alpha:1]];
    [self addSubview:self.doneButton];

}

- (void)setUpView:(NSArray*)movies withDraggableImageView:(DraggableImageView *)draggableImageView {
    self.movieChoiceOne = @"none";
    self.movieChoiceTwo = @"none";
    self.movieChoiceThree = @"none";
    
    self.moviePosterOne.center = self.moviePosterOneOriginalCenter;
    self.moviePosterTwo.center = self.moviePosterTwoOriginalCenter;
    self.moviePosterThree.center = self.moviePosterThreeOriginalCenter;
    
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
    while (randThree == randTwo || randThree == randOne) {
        randThree = arc4random_uniform(19);
    }

    NSDictionary *movieOne = movies[randOne];
    NSDictionary *movieTwo = movies[randTwo];
    NSDictionary *movieThree = movies[randThree];
    
    NSString *thumbnailString = movieOne[@"posters"][@"thumbnail"];
    NSURL *url = [NSURL URLWithString:thumbnailString];
    [self.moviePosterOne setImageWithURL:url];

    NSString *thumbnailTwoString = movieTwo[@"posters"][@"thumbnail"];
    NSURL *urlTwo = [NSURL URLWithString:thumbnailTwoString];
    [self.moviePosterTwo setImageWithURL:urlTwo];

    NSString *thumbnailThreeString = movieThree[@"posters"][@"thumbnail"];
    NSURL *urlThree = [NSURL URLWithString:thumbnailThreeString];
    [self.moviePosterThree setImageWithURL:urlThree];

    self.matchName.text = draggableImageView.currentMatch.name;
    self.matchProfilePic.image = draggableImageView.profileImageView.image;
    self.matchId = draggableImageView.currentMatch.email;
    
    MovieDetailsView *movieDetailsOne = [[[NSBundle mainBundle] loadNibNamed:@"MovieDetailsView" owner:self options:nil] objectAtIndex:0];
    [movieDetailsOne setUpView:movieOne];
    self.movieDetailsOne = movieDetailsOne;
    [self addSubview:self.movieDetailsOne];
    [self.movieDetailsOne setHidden:YES];
    [self sendSubviewToBack:self.movieDetailsOne];

    MovieDetailsView *movieDetailsTwo = [[[NSBundle mainBundle] loadNibNamed:@"MovieDetailsView" owner:self options:nil] objectAtIndex:0];
    [movieDetailsTwo setUpView:movieTwo];
    self.movieDetailsTwo = movieDetailsTwo;
    [self addSubview:self.movieDetailsTwo];
    [self.movieDetailsTwo setHidden:YES];
    [self sendSubviewToBack:self.movieDetailsTwo];

    MovieDetailsView *movieDetailsThree = [[[NSBundle mainBundle] loadNibNamed:@"MovieDetailsView" owner:self options:nil] objectAtIndex:0];
    [movieDetailsThree setUpView:movieThree];
    self.movieDetailsThree = movieDetailsThree;
    [self addSubview:self.movieDetailsThree];
    [self.movieDetailsThree setHidden:YES];
    [self sendSubviewToBack:self.movieDetailsThree];
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
    self.movieChoiceOne = @"nope";
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
    self.movieChoiceTwo = @"nope";
}

- (IBAction)onNopeTapThree:(id)sender {
    [UIView animateWithDuration:.3 animations:^{
        self.moviePosterThree.center = self.nopeButtonThreeCenter;
        self.likeThree.alpha = 0;
    } completion:^(BOOL finished) {
        self.likeThree.alpha = 0;
        [UIView animateWithDuration:.3 animations:^{
            self.nopeThree.alpha = 1;
        }];

    }];
    self.movieChoiceThree = @"nope";
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
    self.movieChoiceOne = @"like";
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
    self.movieChoiceTwo = @"like";
}

- (IBAction)onLikeTapThree:(id)sender {
    [UIView animateWithDuration:.3 animations:^{
        self.moviePosterThree.center = self.likeButtonThreeCenter;
        self.nopeThree.alpha = 0;
    } completion:^(BOOL finished) {
        self.nopeThree.alpha = 0;
        [UIView animateWithDuration:.3 animations:^{
            self.likeThree.alpha = 1;
        }];

    }];
    self.movieChoiceThree = @"like";
}

- (IBAction)onMoviePosterOneTap:(id)sender {
    NSLog(@"poster one tap!");
    [self.movieDetailsOne setHidden:NO];
    [self bringSubviewToFront:self.movieDetailsOne];
}
- (IBAction)onMoviePosterTwoTap:(id)sender {
    NSLog(@"poster two tap!");
    [self.movieDetailsTwo setHidden:NO];
    [self bringSubviewToFront:self.movieDetailsTwo];

}

- (IBAction)onMoviePosterThreeTap:(id)sender {
    NSLog(@"poster three tap!");
    [self.movieDetailsThree setHidden:NO];
    [self bringSubviewToFront:self.movieDetailsThree];
}

- (IBAction)onMovieOnePan:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self];
    
    CGFloat translationX = translation.x;
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.currentlyPanningOriginalCenter = self.moviePosterOne.center;
    } else if (sender.state == UIGestureRecognizerStateChanged) {

        if ( (self.currentlyPanningOriginalCenter.x + translationX) < self.nopeButtonOneCenter.x) {
            self.moviePosterOne.center = CGPointMake(self.nopeButtonOneCenter.x, self.currentlyPanningOriginalCenter.y);
        } else if ((self.currentlyPanningOriginalCenter.x + translationX) > self.likeButtonOneCenter.x) {
            self.moviePosterOne.center = CGPointMake(self.likeButtonOneCenter.x, self.currentlyPanningOriginalCenter.y);
        } else {
            self.moviePosterOne.center = CGPointMake(self.currentlyPanningOriginalCenter.x + translationX, self.currentlyPanningOriginalCenter.y);
        }
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        if (translationX < 0) {
            [self onNopeTapOne:nil];
        }
        if (translationX > 0) {
            [self onLikeTapOne:nil];
        }
    }
}

- (IBAction)onMovieTwoPan:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self];
    
    CGFloat translationX = translation.x;
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.currentlyPanningOriginalCenter = self.moviePosterTwo.center;
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        
        if ( (self.currentlyPanningOriginalCenter.x + translationX) < self.nopeButtonTwoCenter.x) {
            self.moviePosterTwo.center = CGPointMake(self.nopeButtonTwoCenter.x, self.currentlyPanningOriginalCenter.y);
        } else if ((self.currentlyPanningOriginalCenter.x + translationX) > self.likeButtonTwoCenter.x) {
            self.moviePosterTwo.center = CGPointMake(self.likeButtonTwoCenter.x, self.currentlyPanningOriginalCenter.y);
        } else {
            self.moviePosterTwo.center = CGPointMake(self.currentlyPanningOriginalCenter.x + translationX, self.currentlyPanningOriginalCenter.y);
        }
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        if (translationX < 0) {
            [self onNopeTapTwo:nil];
        }
        if (translationX > 0) {
            [self onLikeTapTwo:nil];
        }
    }

}
- (IBAction)onMovieThreePan:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self];
    
    CGFloat translationX = translation.x;
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.currentlyPanningOriginalCenter = self.moviePosterThree.center;
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        
        if ( (self.currentlyPanningOriginalCenter.x + translationX) < self.nopeButtonThreeCenter.x) {
            self.moviePosterThree.center = CGPointMake(self.nopeButtonThreeCenter.x, self.currentlyPanningOriginalCenter.y);
        } else if ((self.currentlyPanningOriginalCenter.x + translationX) > self.likeButtonThreeCenter.x) {
            self.moviePosterThree.center = CGPointMake(self.likeButtonThreeCenter.x, self.currentlyPanningOriginalCenter.y);
        } else {
            self.moviePosterThree.center = CGPointMake(self.currentlyPanningOriginalCenter.x + translationX, self.currentlyPanningOriginalCenter.y);
        }
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        if (translationX < 0) {
            [self onNopeTapThree:nil];
        }
        if (translationX > 0) {
            [self onLikeTapThree:nil];
        }
    }

}

//-(void)onDetailsDoneTap {
//    NSLog(@"details done tapped");
//    [self hideSubView:self.moviePosterOne];
//    [self hideSubView:self.moviePosterTwo];
//    [self hideSubView:self.MoviePosterThree];
//}


@end
