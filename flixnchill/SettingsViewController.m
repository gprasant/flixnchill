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
	NSString *userId = [[FBSDKAccessToken currentAccessToken] userID];
	NSLog(@"User logged in with usedID = %@", [[FBSDKAccessToken currentAccessToken] userID]);
	NSDictionary *params = @{@"fields": @"name"};
	
	FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
								  initWithGraphPath:userId
								  parameters:params
								  HTTPMethod:@"GET"];
	[request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
										  id result,
										  NSError *error) {
		NSLog(@"Success");
		NSDictionary *data = (NSDictionary *)result;
		self.userNameLabel.text = [data objectForKey:@"name"];
	}];
	
	NSString *userPicture = [userId stringByAppendingString:@"/picture"];
	NSDictionary *imageParams = @{@"height": @160, @"width": @160, @"type": @"square", @"redirect": @0};
	FBSDKGraphRequest *imageRequest = [[FBSDKGraphRequest alloc]
								  initWithGraphPath:userPicture
								  parameters:imageParams
								  HTTPMethod:@"GET"];
	[imageRequest startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
										  id result,
										  NSError *error) {
		NSLog(@"Got image");
		NSDictionary *imageData = (NSDictionary *)result;
		NSURL *url = [NSURL URLWithString:[[imageData objectForKey:@"data"] objectForKey:@"url"]];
		[self.profileImageView setImageWithURL:url];
	}];
	
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
