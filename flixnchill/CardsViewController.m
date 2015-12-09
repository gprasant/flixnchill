//
//  ViewController.m
//  tinder
//
//  Created by Prasanth Guruprasad on 11/19/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "CardsViewController.h"
#import "DraggableImageView.h"
#import "ProfileViewController.h"
#import "FlixNChillClient.h"
#import "PotentialMatch.h"
#import <Parse/Parse.h>
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"
#import "ThreeMoviesView.h"
#import "MovieDetailsView.h"

@interface CardsViewController () <ThreeMoviesViewDelegate, MovieDetailsViewDelegate, DraggableImageViewDelegate>

@property (strong, nonatomic) NSArray *movies;

@property (strong, nonatomic) NSMutableArray *matchCandidatesArray;

@property (strong, nonatomic) IBOutlet DraggableImageView *draggableCard;

@property (weak, nonatomic) IBOutlet UIImageView *settingsButton;
@property (weak, nonatomic) IBOutlet UIImageView *messagesButton;
@property (weak, nonatomic) IBOutlet UIImageView *nopeButton;
@property (weak, nonatomic) IBOutlet UIImageView *infoButton;
@property (weak, nonatomic) IBOutlet UIImageView *heartButton;

@end

@implementation CardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchMovies];
    
    [self.view addSubview:self.blurView];
    [self hideSubView:self.blurView];
    
    self.movieCardsView = [self setUpMoviesView];

    [self.view addSubview:self.movieCardsView];
    [self hideSubView:self.movieCardsView];

	UIColor *netflixRed = [UIColor colorWithRed:(185/255.0) green:(9/255.0) blue:(11/255.0) alpha:1] ;
	self.view.backgroundColor = netflixRed;
    // Test parse network call
    NSDictionary *d = [[NSDictionary alloc] init];
    [[FlixNChillClient sharedInstance] getMatchCandidatesWithParams: d completion:^(NSArray *candidates, NSError *error) {
        NSMutableArray *matchCandidatesArray = [NSMutableArray array];
        if (!error) {
            for (PFObject *o in candidates) {
                [matchCandidatesArray addObject:[[PotentialMatch alloc] initFromPFObject: o]];
            }
            self.draggableCard.matchCandidatesArray = matchCandidatesArray;
            [self initSubViews];
        }
    }];
	[self.view bringSubviewToFront:self.draggableCard];
	[self setNeedsStatusBarAppearanceUpdate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual: @"profileViewSegue"]) {
        UIViewController *destinationVC = [segue destinationViewController];
        ProfileViewController * pvc = (ProfileViewController *)destinationVC;
		pvc.image = self.draggableCard.profileImageView.image;
		pvc.user = self.draggableCard.currentMatch;
    } else if ([segue.identifier isEqual: @"chatsViewSegue"]) {
    
    }
}

#pragma mark - Gesture recognizers

- (IBAction)onResetTapped:(UITapGestureRecognizer *)sender {
    [self.draggableCard reset];
}

- (IBAction)onSettingsButtonTapped:(UITapGestureRecognizer *)sender {
    NSLog(@"CardsViewController:Settings tapped");
}

- (IBAction)onMessagesTapped:(UITapGestureRecognizer *)sender {
    NSLog(@"CardsViewController:Messages tapped");
}

- (IBAction)onNopeButtonTapped:(UITapGestureRecognizer *)sender {
    NSLog(@"CardsViewController:Nope tapped");
    [self.draggableCard swipeLeft];
}

- (IBAction)onInfoButtonTapped:(UITapGestureRecognizer *)sender {
    NSLog(@"CardsViewController:Info tapped");
}

- (IBAction)onLikeTapped:(UITapGestureRecognizer *)sender {
    NSLog(@"CardsViewController:Like tapped");
    [self showSubview:self.blurView];
    
    [self.movieCardsView setUpView:self.movies withDraggableImageView:self.draggableCard];
    [self showSubview:self.movieCardsView];

    [self.draggableCard swipeRight];
}

#pragma mark - END Gesture recognizers

- (void)onSwipeRight {
    [self onLikeTapped:nil];
}

- (ThreeMoviesView*)setUpMoviesView {
    ThreeMoviesView *threeMoviesView = [[[NSBundle mainBundle] loadNibNamed:@"ThreeMoviesView" owner:self options:nil] objectAtIndex:0];
    threeMoviesView.center = CGPointMake(160.0f, 310.0f);
    threeMoviesView.delegate = self;
    threeMoviesView.movieDetailsOne.delegate = self;
    threeMoviesView.movieDetailsTwo.delegate = self;
    threeMoviesView.movieDetailsThree.delegate = self;
    

    [threeMoviesView setHidden:YES];

    return threeMoviesView;
}

- (void)hideSubView:(UIView*)subview {
    [subview setHidden:YES];
    [self.view sendSubviewToBack:subview];
}

- (void)showSubview:(UIView*)subview {
    [subview setHidden:NO];
    [self.view bringSubviewToFront:subview];
}

- (void)onDoneTap {
    NSLog(@"3movies done tapped");
    [self hideSubView:self.blurView];
    [self hideSubView:self.movieCardsView];
}

-(void)onDetailsDoneTap {
    NSLog(@"details done tapped");
    [self.movieCardsView.movieDetailsOne setHidden:YES];
    [self.movieCardsView sendSubviewToBack:self.movieCardsView.movieDetailsOne];

    [self.movieCardsView.movieDetailsTwo setHidden:YES];
    [self.movieCardsView sendSubviewToBack:self.movieCardsView.movieDetailsTwo];

    [self.movieCardsView.movieDetailsThree setHidden:YES];
    [self.movieCardsView sendSubviewToBack:self.movieCardsView.movieDetailsThree];
}

-(void) initSubViews {
    [self.draggableCard bindWithNextMatch];
    self.draggableCard.delegate = self;
}

- (BOOL) fetchMovies {
    __block BOOL successfulFetch = NO;
    NSString *urlString = @"https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        NSError *jsonError = nil;

        NSDictionary *responseDictionary =
        [NSJSONSerialization JSONObjectWithData:responseObject
                                        options:kNilOptions
                                          error:&jsonError];
        self.movies = responseDictionary[@"movies"];
        successfulFetch = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    return successfulFetch;
}

- (UIStatusBarStyle) preferredStatusBarStyle {
	return UIStatusBarStyleLightContent;
}

@end
