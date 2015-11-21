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

- (IBAction)onDismissTapped:(UITapGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void) setupViews {
    [self.profilePictureImageView setImage:self.image];
}

@end
