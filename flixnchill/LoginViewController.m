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
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIImageView *placeHolderImageView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	UIColor *netflixRed = [UIColor colorWithRed:(185/255.0) green:(9/255.0) blue:(11/255.0) alpha:1] ;
	self.view.backgroundColor = netflixRed;
    [self setupViews];
	FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
	loginButton.center = self.loginButton.center;
	[self.view addSubview:loginButton];
	_fbLoginButton.readPermissions =
	@[@"public_profile", @"email", @"user_friends"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupViews {
    self.loginButton.layer.borderWidth = 1.0f;
    self.loginButton.layer.borderColor = [[UIColor blackColor] CGColor];
    [self addTaylorGIF];
}

-(void) addTaylorGIF {
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
	FLAnimatedImage *manWalkingImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"taylorHeart" ofType:@"gif"]]];

    imageView.animatedImage = manWalkingImage;
    imageView.frame = self.placeHolderImageView.frame;
    [self.view addSubview:imageView];
}


@end
