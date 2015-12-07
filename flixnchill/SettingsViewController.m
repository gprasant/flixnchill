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
@property (weak, nonatomic) IBOutlet UIButton *logoutPlaceholderbutton;
@property (strong, nonatomic) UIButton *myLoginButton;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	UIColor *netflixRed = [UIColor colorWithRed:(185/255.0) green:(9/255.0) blue:(11/255.0) alpha:1] ;
	self.view.backgroundColor = netflixRed;
	// Do any additional setup after loading the view.

	
	self.myLoginButton=[UIButton buttonWithType:UIButtonTypeCustom];
	self.myLoginButton.frame=CGRectMake(0,0,220,40);
	CALayer *layer = self.myLoginButton.layer;
	layer.backgroundColor = [[UIColor clearColor] CGColor];
	layer.borderColor = [[UIColor whiteColor] CGColor];
	layer.cornerRadius = 8.0f;
	layer.borderWidth = 1.0f;
	
	self.myLoginButton.center = self.view.center;
	if([FBSDKAccessToken currentAccessToken]){
		[self.myLoginButton setTitle: @"Log Out" forState: UIControlStateNormal];
	} else {
		[self.myLoginButton setTitle: @"Log In" forState: UIControlStateNormal];
	}
	// Handle clicks on the button
	[self.myLoginButton
	 addTarget:self
	 action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
	self.myLoginButton.center = self.logoutPlaceholderbutton.center;
	[self.view addSubview:self.myLoginButton];
	
	User *user = [User currentUser];
	NSURL *url = [NSURL URLWithString:user.profileImageUrl];
	[self.profileImageView setImageWithURL:url];
	self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
	self.profileImageView.clipsToBounds = YES;
	
	self.userNameLabel.text = user.name;
	[self setNeedsStatusBarAppearanceUpdate];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBackTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
	return UIStatusBarStyleLightContent;
}

// Once the button is clicked, show the login dialog
-(void)loginButtonClicked
{
	if([FBSDKAccessToken currentAccessToken]){
		[[FBSDKLoginManager new] logOut];
		NSLog(@"Did log out");
		[self.myLoginButton setTitle: @"Log In" forState: UIControlStateNormal];
	} else {
	
		FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
		[login
		 logInWithReadPermissions: @[@"public_profile"]
		 fromViewController:self
		 handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
			 if (error) {
				 NSLog(@"Process error");
			 } else if (result.isCancelled) {
				 NSLog(@"Cancelled");
			 } else {
				 NSLog(@"Logged in");
				[self.myLoginButton setTitle: @"Log Out" forState: UIControlStateNormal];
			 }
		 }];
	}
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
