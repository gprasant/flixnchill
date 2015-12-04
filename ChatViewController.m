//
//  ChatViewController.m
//  flixnchill
//
//  Created by Prasanth Guruprasad on 12/2/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "ChatViewController.h"
#import "PubNubClient.h"

@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *chatWithLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *chatTextField;
@property (weak, nonatomic) IBOutlet UITableView *messagesTableView;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [self setupTableView];
    [self setupViews];
    [super viewDidLoad];
    // Do any additional setup after loading the view.

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
    NSString *messageText = self.chatTextField.text;
    self.chatTextField.text = @"";
    [[PubNubClient sharedInstance] sendMessage:messageText];
}

-(void) setupViews {
    self.chatWithLabel.text = self.chatWith.name;
}

#pragma mark TableView methods
-(void) setupTableView {
    self.messagesTableView.dataSource = self;
    self.messagesTableView.delegate = self;
    UINib *messageCell = [UINib nibWithNibName:@"MessageCell" bundle:nil];
    [self.messagesTableView registerNib:messageCell forCellReuseIdentifier:@"MessageCell"];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    return cell;
}
#pragma mark END TableView methods

@end
