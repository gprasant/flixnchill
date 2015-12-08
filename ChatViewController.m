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

const NSString *PUBNUB_PUB_KEY = @"pub-c-fcaa8727-17b2-40b6-a0cd-f153f2ac72df";
const NSString *PUBNUB_SUB_KEY = @"sub-c-ead124cc-99d6-11e5-9a49-02ee2ddab7fe";


@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource, PNObjectEventListener, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *chatWithLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *chatTextField;
@property (weak, nonatomic) IBOutlet UITableView *messagesTableView;
@property (strong, nonatomic) NSString *channelName;

@property (strong, nonatomic) NSMutableArray *messages;
@property (nonatomic) PubNub *client;
@end

@implementation ChatViewController

- (void) viewDidLoad {
    [self setupTableView];
    [self setupViews];
    [self setupPubNub];
    [super viewDidLoad];
    self.messages = [NSMutableArray array];
    // Do any additional setup after loading the view.
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) onBackTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendButtonTapped:(id)sender {
    NSString *messageText = self.chatTextField.text;
    [self sendMessage: messageText];

    self.chatTextField.text = @"";
}

-(void) setupViews {
    self.chatWithLabel.text = self.chatWith.name;
    self.chatTextField.delegate = self;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self.chatTextField resignFirstResponder];
    return NO;
}

#pragma mark TableView methods
-(void) setupTableView {
    self.messagesTableView.dataSource = self;
    self.messagesTableView.delegate = self;
    UINib *messageCell = [UINib nibWithNibName:@"MessageCell" bundle:nil];
    [self.messagesTableView registerNib:messageCell forCellReuseIdentifier:@"MessageCell"];
    self.messagesTableView.estimatedRowHeight = 100.0f;
    self.messagesTableView.separatorColor = [UIColor clearColor];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    NSDictionary *message = self.messages[indexPath.row];
    if ([message[@"author"] isEqualToString:[User currentUser].name]) {
        cell.otherPersonMessageLabel.text = @"";
        cell.myMessageLabel.text = [NSString stringWithFormat:@"  %@  ", message[@"text"]];
    } else {
        cell.myMessageLabel.text = @"";
        cell.otherPersonMessageLabel.text = [NSString stringWithFormat:@"  %@  ", message[@"text"]];
    }
    
    return cell;
}

- (void) scrollTableToBottomAnimated: (BOOL) animated {
    int rowNumber = [self.messagesTableView numberOfRowsInSection:0];
    if (rowNumber > 0) [self.messagesTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rowNumber-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
}

- (void) scrollTableToBottom {
    [self scrollTableToBottomAnimated: NO];
}
#pragma mark END TableView methods

#pragma mark PubNub methods
- (void) setupPubNub {
    self.channelName = [self generateChannelName];
    PNConfiguration *config = [PNConfiguration configurationWithPublishKey:PUBNUB_PUB_KEY subscribeKey:PUBNUB_SUB_KEY];
    self.client = [PubNub clientWithConfiguration:config];
    [self.client addListener:self];
    [self.client subscribeToChannels:@[self.channelName] withPresence:YES];
    [self loadHistoryForChannel: self.channelName];
}
- (void) loadHistoryForChannel: (NSString *)channel {
    [self.client historyForChannel:channel start:nil end:nil limit:100 withCompletion:^(PNHistoryResult *result, PNErrorStatus *status) {
        if (!status.isError) {
            [self.messages addObjectsFromArray:result.data.messages];
            [self.messagesTableView reloadData];
            [self scrollTableToBottomAnimated: NO];
        }
    }];
}

- (void) client:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {
    if ([message.data.message[@"author"] isEqualToString:[User currentUser].name]) {
        return; // return if the currently received message is from self, as it would have already been added
    }
    [self.messages addObject:message.data.message];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.messages.count - 1) inSection:0];
    [self.messagesTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [self scrollTableToBottom];
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
    [self.client publish: messageDictionary toChannel: self.channelName storeInHistory:YES
          withCompletion:^(PNPublishStatus *status) {
              if (!status.isError) {
                  NSLog(@"Successfully sent message");

              }

              else {
                  
              }
          }
     ];
    [self.messages addObject:messageDictionary];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.messages.count - 1) inSection:0];
    [self.messagesTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    [self scrollTableToBottom];
}

// Gives back a channel name for user1 &user2 to converse (user1Email:user2Email), s.t. user1Email < user2Email
- (NSString *) generateChannelName {
    NSString *myEmail = [User currentUser].email;
    NSString *otherEmail = self.chatWith.email;
    if ( [myEmail caseInsensitiveCompare:otherEmail] == NSOrderedAscending ) {
        return [NSString stringWithFormat:@"%@:%@", myEmail, otherEmail];
    } else {
        return [NSString stringWithFormat:@"%@:%@", otherEmail, myEmail];
    }
}
#pragma mark END PubNub methods

@end
