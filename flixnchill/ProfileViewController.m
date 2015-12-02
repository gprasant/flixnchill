//
//  ProfileViewController.m
//  tinder
//
//  Created by Prasanth Guruprasad on 11/19/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *taglineLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	UIColor *netflixRed = [UIColor colorWithRed:(185/255.0) green:(9/255.0) blue:(11/255.0) alpha:1] ;
	self.view.backgroundColor = netflixRed;
    [self setupViews];
	self.nameAgeLabel.text = [NSString stringWithFormat:@"%@, %@", self.user.name, self.user.age];
	self.taglineLabel.text = self.user.tagline;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) setupViews {
    [self.profilePictureImageView setImage:self.image];
}

#pragma mark - BEGIN Gesture recognizers

- (IBAction)onDoneTapped:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)onNopeTapped:(UITapGestureRecognizer *)sender {
    NSLog(@"ProfileViewController:Nope tapped");
}

- (IBAction)onLikeTapped:(UITapGestureRecognizer *)sender {
    NSLog(@"ProfileViewController:Like tapped");
}
#pragma mark - END Gesture recognizers
@end
