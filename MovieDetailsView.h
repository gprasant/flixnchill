//
//  MovieDetailsView.h
//  flixnchill
//
//  Created by Greyson Gregory on 12/5/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MovieDetailsViewDelegate <NSObject>

-(void)onDetailsDoneTap;

@end

@interface MovieDetailsView : UIView
@property (assign) id<MovieDetailsViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *movieTilteLabel;
@property (weak, nonatomic) IBOutlet UIWebView *movieTrailerView;
@property (weak, nonatomic) IBOutlet UIScrollView *summaryLabelContainer;
@property (weak, nonatomic) IBOutlet UILabel *movieSummaryLabel;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

//- (IBAction)onDoneTap:(id)sender;

- (void)setUpView:(NSDictionary*)movie;
@end
