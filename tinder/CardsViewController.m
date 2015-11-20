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

@interface CardsViewController ()
@property (strong, nonatomic) IBOutlet DraggableImageView *profileImageView;
@end

@implementation CardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.profileImageView.profileImageView.image = [UIImage imageNamed:@"taylor"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onBottomImageTapped:(UITapGestureRecognizer *)sender {
    [self.profileImageView reset];
}

- (IBAction)onImageTapped:(UITapGestureRecognizer *)sender {
//    ProfileViewController *pvc = [[ProfileViewController alloc] init];
//    pvc.image = [UIImage imageNamed:@"taylor"];
//    
//    [self presentViewController:pvc
//                       animated:YES
//                     completion:nil];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destinationVC = [segue destinationViewController];
    ProfileViewController * pvc = (ProfileViewController *)destinationVC;
    pvc.image = [UIImage imageNamed:@"taylor"];
}

@end
