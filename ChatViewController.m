//
//  ChatViewController.m
//  flixnchill
//
//  Created by Prasanth Guruprasad on 12/2/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "ChatViewController.h"
#import "MessageCell.h"
#import "User.h"

#import <PubNub/PubNub.h>

@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource, PNObjectEventListener>
@property (weak, nonatomic) IBOutlet UILabel *chatWithLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *chatTextField;
@property (weak, nonatomic) IBOutlet UITableView *messagesTableView;

@property (strong, nonatomic) NSMutableArray *messages;
@property (nonatomic) PubNub *client;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [self setupTableView];
    [self setupViews];
    [self setupPubNub];
    [super viewDidLoad];
    self.messages = [NSMutableArray array];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBackTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendButtonTapped:(id)sender {
    NSString *messageText = self.chatTextField.text;
    [self sendMessage: messageText];

    self.chatTextField.text = @"";
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
    self.messagesTableView.estimatedRowHeight = 100.0f;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    NSDictionary *message = self.messages[indexPath.row];
    if ([message[@"author"] isEqualToString:[User currentUser].name]) {
        cell.otherPersonMessageLabel.text = @"";
        cell.myMessageLabel.text = message[@"text"];
    } else {
        cell.myMessageLabel.text = @"";
        cell.otherPersonMessageLabel.text = message[@"text"];
    }
    
    return cell;
}

- (void)scrollTableToBottom {
    int rowNumber = [self.messagesTableView numberOfRowsInSection:0];
    if (rowNumber > 0) [self.messagesTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rowNumber-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
#pragma mark END TableView methods

#pragma mark PubNub methods
- (void) setupPubNub {
    PNConfiguration *config = [PNConfiguration configurationWithPublishKey:@"demo" subscribeKey:@"demo"];
    self.client = [PubNub clientWithConfiguration:config];
    [self.client addListener:self];
    [self.client subscribeToChannels:@[@"my_channel"] withPresence:YES];
    
}

- (void)client:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {
    [self.messages addObject:message.data.message];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.messages.count - 1) inSection:0];
    UITableViewRowAnimation direction = UITableViewRowAnimationLeft; // Left by default. Change if needed
    if ([message.data.message[@"author"] isEqualToString: [User currentUser].name]) {
        direction = UITableViewRowAnimationRight;
    }
    [self.messagesTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:direction];
    [self scrollTableToBottom];
    // should use messagesTableView reloadRowsAtIndexPaths: ... method
    NSLog(@"Received message: %@ on channel %@ at %@", message.data.message,
          message.data.subscribedChannel, message.data.timetoken);
}

- (void) sendMessage: (NSString *)messageText {
    if ([[messageText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        // empty message
        return;
    }
    User * me = [User currentUser];
    NSLog(@"Attempting Message Send : %@", messageText);
    NSMutableDictionary *messageDictionary = [NSMutableDictionary dictionary];
    messageDictionary[@"text"]   = messageText;
    messageDictionary[@"author"] = me.name;
    [self.client publish: messageDictionary toChannel: @"my_channel" storeInHistory:YES
          withCompletion:^(PNPublishStatus *status) {
              if (!status.isError) {
                  NSLog(@"Successfully sent message");

              }

              else {
                  
              }
          }
     ];

}
#pragma mark END PubNub methods

@end
