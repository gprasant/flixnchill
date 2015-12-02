//
//  SettingsViewController.m
//  tinder
//
//  Created by Prasanth Guruprasad on 11/21/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "SettingsViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "UIImageView+AFNetworking.h"
#import "User.h"


@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	UIColor *netflixRed = [UIColor colorWithRed:(185/255.0) green:(9/255.0) blue:(11/255.0) alpha:1] ;
	self.view.backgroundColor = netflixRed;
	// Do any additional setup after loading the view.
	FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
	// Optional: Place the button in the center of your view.
	loginButton.center = self.view.center;
	[self.view addSubview:loginButton];
	User *user = [User currentUser];
	NSURL *url = [NSURL URLWithString:user.profileImageUrl];
	[self.profileImageView setImageWithURL:url];
	self.userNameLabel.text = user.name;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBackTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
