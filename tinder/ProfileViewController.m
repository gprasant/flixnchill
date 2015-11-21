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

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) setupViews {
    [self.profilePictureImageView setImage:self.image];
}

#pragma mark - BEGIN Gesture recognizers

- (IBAction)onDoneTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onNopeTapped:(UITapGestureRecognizer *)sender {
    NSLog(@"ProfileViewController:Nope tapped");
}

- (IBAction)onLikeTapped:(UITapGestureRecognizer *)sender {
    NSLog(@"ProfileViewController:Like tapped");
}
#pragma mark - END Gesture recognizers
@end
