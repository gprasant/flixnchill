//
//  LoginViewController.m
//  tinder
//
//  Created by Prasanth Guruprasad on 11/21/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "LoginViewController.h"
#import "FLAnimatedImage.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButtonPlaceHolder;
@property (weak, nonatomic) IBOutlet UIImageView *placeHolderImageView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	UIColor *netflixRed = [UIColor colorWithRed:(185/255.0) green:(9/255.0) blue:(11/255.0) alpha:1] ;
	self.view.backgroundColor = netflixRed;
	[self setupViews];
	self.loginButton = [[FBSDKLoginButton alloc] init];
	self.loginButton.center = self.loginButtonPlaceHolder.center;
	[self.view addSubview:self.loginButton];
	self.loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
	[self setNeedsStatusBarAppearanceUpdate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupViews {
    self.loginButton.layer.borderWidth = 1.0f;
    self.loginButton.layer.borderColor = [[UIColor blackColor] CGColor];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
	return UIStatusBarStyleLightContent;
}

@end
