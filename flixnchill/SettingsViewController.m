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
#import "SettingsTableViewCell.h"
#import "LoginViewController.h"
#import "colorMARKRangeSlider.h"


@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *ageRangeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *logoutPlaceholderbutton;
@property (strong, nonatomic) UIButton *myLoginButton;
@property (weak, nonatomic) IBOutlet UITableView *detailsTableView;
@property (strong, nonatomic) NSMutableDictionary *userDetails;
@property (strong, nonatomic) colorMARKRangeSlider *rangeSlider;
@property (weak, nonatomic) IBOutlet UILabel *rangeSliderPlaceHolder;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self setupTableView];
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

	//init rect
	CGRect aRect = CGRectMake(self.rangeSliderPlaceHolder.frame.origin.x, self.rangeSliderPlaceHolder.frame.origin.y, self.rangeSliderPlaceHolder.frame.size.width, self.rangeSliderPlaceHolder.frame.size.height);
	self.rangeSlider = [[colorMARKRangeSlider alloc] initWithFrame:aRect];
	[self.rangeSlider addTarget:self
						 action:@selector(rangeSliderValueDidChange:)
			   forControlEvents:UIControlEventValueChanged];
	//self.rangeSlider.minimumValue = 16.0; -- doesnt work
	self.rangeSlider.maximumValue = 29.0;
	self.rangeSlider.leftValue = 0.0;
	self.rangeSlider.rightValue = 9.0;
	self.rangeSlider.minimumDistance = 0.0;
	[self.view addSubview:self.rangeSlider];
	self.rangeSlider.center = self.rangeSlider.center;
	[self.rangeSlider setForegroundColor:[UIColor whiteColor]];

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
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
		LoginViewController *loginVC = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
		[self presentViewController:loginVC animated:YES completion:nil];
	} else {
	
		FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
		[login
		 logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
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

#pragma mark - BEGIN TableView Methods
- (void) setupTableView {
	self.detailsTableView.delegate = self;
	self.detailsTableView.dataSource = self;
	self.detailsTableView.opaque = NO;
	self.detailsTableView.backgroundColor = [UIColor clearColor];
	self.detailsTableView.backgroundView  = nil;


}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(!self.userDetails){
		self.userDetails = [[NSMutableDictionary alloc]init];
		User *user = [User currentUser];
		if(user.gender){
			[self.userDetails setValue:user.gender forKey:@"Gender"];
		}
		if(user.location){
			[self.userDetails setValue:user.location forKey:@"Location"];
		}
		if(user.matches){
			[self.userDetails setValue:[NSString stringWithFormat:@"%d",[user.matches count]] forKey:@"Matches"];
		}
		if(user.friends){
			[self.userDetails setValue:user.friends forKey:@"Friends flixin' & chillin'"];
		}
	}
	return [self.userDetails count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	SettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingsCell"];
	if(!cell){
		cell = [[SettingsTableViewCell alloc] init];
	}
	NSArray *keys=[self.userDetails allKeys];
	NSString *key = [keys objectAtIndex:[indexPath row]];
	cell.ValueLabel.text = [self.userDetails valueForKey:key];
	cell.KeyLabel.text = key;
	cell.backgroundColor = [UIColor clearColor];
	return cell;
}

- (void)rangeSliderValueDidChange:(MARKRangeSlider *)slider {
	float left = slider.leftValue +21.0;
	float right = slider.rightValue +21.0;
	NSLog(@"%0.0f-%0.0f", left, right);
	NSString *toDisplay = [NSString stringWithFormat:@"%0.0f-%0.0f", left, right];
	self.ageRangeLabel.text = toDisplay;
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
