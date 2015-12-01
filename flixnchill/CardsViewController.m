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

@interface CardsViewController ()

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual: @"profileViewSegue"]) {
        UIViewController *destinationVC = [segue destinationViewController];
        ProfileViewController * pvc = (ProfileViewController *)destinationVC;
        pvc.image = [UIImage imageNamed:@"jessica"];
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
    [self.draggableCard swipeRight];
}

#pragma mark - END Gesture recognizers

-(void) initSubViews {
    [self.draggableCard bindWithNextMatch];
}
@end
