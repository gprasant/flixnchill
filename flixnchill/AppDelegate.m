//
//  AppDelegate.m
//  tinder
//
//  Created by Prasanth Guruprasad on 11/19/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "LoginViewController.h"
#import "CardsViewController.h"
#import "User.h"
#import <PubNub/PubNub.h>

@interface AppDelegate ()

@property (nonatomic) PubNub *client;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupParseLibWithLaunchOptions:launchOptions];
    
    [self setupFacebookLibWithApplication:application
                            LaunchOptions:launchOptions];
    
//    [self setupPubNubLib];
	
		
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	[FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
			openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
		 annotation:(id)annotation {
	// Dismiss login view controller
	BOOL setup = [[FBSDKApplicationDelegate sharedInstance] application:application
														  openURL:url
													  sourceApplication:sourceApplication
													   annotation:annotation];
	if(setup){
		[self startStandardView];
		User *user = [self setUpFacebookUser];
		[User setCurrentUser:user];
	}
	return setup;
}

- (void)startStandardView{
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	CardsViewController *cardsVC = (CardsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CardsViewController"];
	self.window.rootViewController = cardsVC;
	[self.window makeKeyAndVisible];
}

- (User *)setUpFacebookUser{
	User *user = [[User alloc] init];
	NSString *userId = [[FBSDKAccessToken currentAccessToken] userID];
	NSLog(@"User logged in with usedID = %@", [[FBSDKAccessToken currentAccessToken] userID]);
	NSDictionary *params = @{@"fields": @"name,email,first_name"};
	
	FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
								  initWithGraphPath:userId
								  parameters:params
								  HTTPMethod:@"GET"];
	[request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
										  id result,
										  NSError *error) {
		NSLog(@"Success");
		NSDictionary *data = (NSDictionary *)result;
		user.name = [data objectForKey:@"name"];
        user.email = [data objectForKey: @"email"];
        user.firstName = [data objectForKey: @"first_name"];
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
		user.profileImageUrl =[[imageData objectForKey:@"data"] objectForKey:@"url"];
	}];
	
	return user;
}

# pragma mark - Client Libs

-(void) setupParseLibWithLaunchOptions: (NSDictionary *)launchOptions {
    // [Optional] Power your app with Local Datastore. For more info, go to
    // https://parse.com/docs/ios_guide#localdatastore/iOS
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"R4ERGRZtP4Y2sehfMcEqbGRKKD3C2aqcTxwJ2JkG"
                  clientKey:@"tKFdIIDQXFtjT4E0CjVLPjnNqfJJnw9Y3MTqnwOO"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
}

-(void) setupFacebookLibWithApplication:(UIApplication *)application
                          LaunchOptions:(NSDictionary *)launchOptions {
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    
    if (![FBSDKAccessToken currentAccessToken]) {
        NSLog(@"User not logged in");
        // Programitically present login view controller.
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginVC = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        self.window.rootViewController = loginVC;
        [self.window makeKeyAndVisible];
        
    } else {
        NSLog(@"User logged in with usedID = %@", [[FBSDKAccessToken currentAccessToken] userID]);
        
        User *user = [self setUpFacebookUser];
        [User setCurrentUser:user];
    }

}

# pragma mark - END Client Libs
@end
