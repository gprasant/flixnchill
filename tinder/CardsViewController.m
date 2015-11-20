//
//  ViewController.m
//  tinder
//
//  Created by Prasanth Guruprasad on 11/19/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "CardsViewController.h"
#import "DraggableImageView.h"

@interface CardsViewController ()
@property (strong, nonatomic) IBOutlet DraggableImageView *profileImageView;
@end

@implementation CardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.profileImageView.profileImageView.image = [UIImage imageNamed:@"ryan"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onBottomImageTapped:(UITapGestureRecognizer *)sender {
    [self.profileImageView reset];
}

@end
