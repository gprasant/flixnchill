//
//  ChatViewController.m
//  flixnchill
//
//  Created by Prasanth Guruprasad on 12/2/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "ChatViewController.h"
#import "PubNubClient.h"

@interface ChatViewController ()
@property (weak, nonatomic) IBOutlet UILabel *chatWithLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *chatTextField;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PubNubClient *pnClient = [PubNubClient sharedInstance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onBackTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendButtonTapped:(id)sender {
    NSString *text = self.chatTextField.text;
    NSLog (@"Got text : %@", text);
    self.chatTextField.text = @"";
}

@end
