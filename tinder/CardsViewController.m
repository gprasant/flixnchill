//
//  ViewController.m
//  tinder
//
//  Created by Prasanth Guruprasad on 11/19/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "CardsViewController.h"
#import "DraggableImageView.h"
#import "ProfileViewController.h"

#import <Parse/Parse.h>

@interface CardsViewController ()
@property (strong, nonatomic) IBOutlet DraggableImageView *draggableCard;

@property (weak, nonatomic) IBOutlet UIImageView *settingsButton;
@property (weak, nonatomic) IBOutlet UIImageView *messagesButton;
@property (weak, nonatomic) IBOutlet UIImageView *nopeButton;
@property (weak, nonatomic) IBOutlet UIImageView *infoButton;
@property (weak, nonatomic) IBOutlet UIImageView *heartButton;

@end

@implementation CardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.draggableCard.profileImageView.image = [UIImage imageNamed:@"taylor"];
//    [self testParseMessage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual: @"profileViewSegue"]) {
        UIViewController *destinationVC = [segue destinationViewController];
        ProfileViewController * pvc = (ProfileViewController *)destinationVC;
        pvc.image = [UIImage imageNamed:@"taylor"];
    } else if ([segue.identifier isEqual: @"chatsViewSegue"]) {
    
    }
}

#pragma mark - Gesture recognizers

- (IBAction)onResetTapped:(UITapGestureRecognizer *)sender {
    [self.draggableCard reset];
}

- (IBAction)onSettingsButtonTapped:(UITapGestureRecognizer *)sender {
    NSLog(@"CardsViewController:Settings tapped");
}

- (IBAction)onMessagesTapped:(UITapGestureRecognizer *)sender {
    NSLog(@"CardsViewController:Messages tapped");
}

- (IBAction)onNopeButtonTapped:(UITapGestureRecognizer *)sender {
    NSLog(@"CardsViewController:Nope tapped");
}

- (IBAction)onInfoButtonTapped:(UITapGestureRecognizer *)sender {
    NSLog(@"CardsViewController:Info tapped");
}

- (IBAction)onLikeTapped:(UITapGestureRecognizer *)sender {
    NSLog(@"CardsViewController:Like tapped");
}

#pragma mark - END Gesture recognizers

//- (void) testParseMessage {
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"message"] = @"Starbucks lovers";
//    [testObject saveInBackground];
//}

@end
