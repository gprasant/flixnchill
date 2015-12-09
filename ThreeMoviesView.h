//
//  ThreeMoviesView.h
//  flixnchill
//
//  Created by Greyson Gregory on 12/4/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "DraggableImageView.h"
#import "MovieDetailsView.h"

@protocol ThreeMoviesViewDelegate <NSObject>

-(void)onDoneTap;

@end

@interface ThreeMoviesView : UIView
@property (assign) id<ThreeMoviesViewDelegate> delegate;

@property (strong, nonatomic) NSString *movieChoiceOne;
@property (strong, nonatomic) NSString *movieChoiceTwo;
@property (strong, nonatomic) NSString *movieChoiceThree;

@property (strong, nonatomic) IBOutlet MovieDetailsView *movieDetailsOne;
@property (strong, nonatomic) IBOutlet MovieDetailsView *movieDetailsTwo;
@property (strong, nonatomic) IBOutlet MovieDetailsView *movieDetailsThree;

@property (weak, nonatomic) IBOutlet UILabel *matchName;
@property (weak, nonatomic) IBOutlet UIImageView *matchProfilePic;
@property (strong, nonatomic) NSString *matchId;

@property (weak, nonatomic) IBOutlet UILabel *titleMessage;

@property (weak, nonatomic) IBOutlet UIImageView *moviePosterOne;
@property (weak, nonatomic) IBOutlet UIImageView *moviePosterTwo;
@property (weak, nonatomic) IBOutlet UIImageView *moviePosterThree;

@property (weak, nonatomic) IBOutlet UIButton *nopeOneButton;
@property (weak, nonatomic) IBOutlet UIButton *nopeTwoButton;
@property (weak, nonatomic) IBOutlet UIButton *nopeThreeButton;

@property (weak, nonatomic) IBOutlet UIButton *likeOneButton;
@property (weak, nonatomic) IBOutlet UIButton *likeTwoButton;
@property (weak, nonatomic) IBOutlet UIButton *likeThreeButton;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;

- (IBAction)onNopeTapOne:(id)sender;
- (IBAction)onNopeTapTwo:(id)sender;
- (IBAction)onNopeTapThree:(id)sender;

- (IBAction)onLikeTapOne:(id)sender;
- (IBAction)onLikeTapTwo:(id)sender;
- (IBAction)onLikeTapThree:(id)sender;

- (void)setUpView:(NSArray*)movies withDraggableImageView:(DraggableImageView*)draggableImageView;
@end
