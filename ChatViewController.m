//
//  ChatViewController.m
//  flixnchill
//
//  Created by Prasanth Guruprasad on 12/2/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "ChatViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MessageCell.h"
#import "User.h"
#import "MovieComparisonView.h"
#import <Parse/Parse.h>

#import <PubNub/PubNub.h>

const NSString *PUBNUB_PUB_KEY = @"pub-c-fcaa8727-17b2-40b6-a0cd-f153f2ac72df";
const NSString *PUBNUB_SUB_KEY = @"sub-c-ead124cc-99d6-11e5-9a49-02ee2ddab7fe";


@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource, PNObjectEventListener, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *chatWithLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *chatTextField;
@property (weak, nonatomic) IBOutlet UITableView *messagesTableView;
@property (strong, nonatomic) NSString *channelName;
@property (weak, nonatomic) IBOutlet UIView *header;

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

- (void) viewWillAppear:(BOOL)animated {
    [self setupNavBar];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) onBackTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) setupNavBar {
    self.navigationController.navigationBar.hidden = YES;
}

- (IBAction)sendButtonTapped:(id)sender {
    NSString *messageText = self.chatTextField.text;
    [self sendMessage: messageText];

    self.chatTextField.text = @"";
}

-(void) setupViews {
    UIColor *netflixRed = [UIColor colorWithRed:(185/255.0) green:(9/255.0) blue:(11/255.0) alpha:1] ;
    self.header.backgroundColor = netflixRed;
    [self registerForKeyboardNotifications];
    self.chatWithLabel.text = self.chatWith.name;
    self.chatTextField.delegate = self;
    // HACK : TO Push the Content Up beyond the border
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(-20.0, 0.0, 0.0, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self.chatTextField resignFirstResponder];
    return NO;
}

- (void) registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void) keyboardWasShown: (NSNotification *)aNotification {
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(-kbSize.height, 0.0, kbSize.height, 0.0);
    
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void) keyboardWillBeHidden: (NSNotification *)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark TableView methods
-(void) setupTableView {
    UITapGestureRecognizer *tapTableGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnTableView)];
    [self.messagesTableView addGestureRecognizer:tapTableGR];
    self.messagesTableView.dataSource = self;
    self.messagesTableView.delegate = self;
    UINib *messageCell = [UINib nibWithNibName:@"MessageCell" bundle:nil];
    [self.messagesTableView registerNib:messageCell forCellReuseIdentifier:@"MessageCell"];
    self.messagesTableView.estimatedRowHeight = 100.0f;
    self.messagesTableView.separatorColor = [UIColor clearColor];
    
    UINib *movieComparisonCell = [UINib nibWithNibName:@"MovieComparisonView" bundle:nil];
    [self.messagesTableView registerNib:movieComparisonCell forCellReuseIdentifier:@"MovieComparisonView"];

}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.messages.count;
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        MovieComparisonView *comparisonView = [tableView dequeueReusableCellWithIdentifier:@"MovieComparisonView"];
        comparisonView.matchLikedLabel.text = [NSString stringWithFormat:@"  %@ prefers:  ", self.chatWith.name];
        //set up movie comparison
        
        PFQuery *query = [PFQuery queryWithClassName:@"MatchMovieInfo"];
        [query whereKey:@"currentUser" equalTo:[User currentUser].email];
        [query whereKey:@"matchedUser" equalTo:self.chatWith.email];
        [query orderByDescending:@"createdAt"];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
            if (!error) {
                NSLog(@"%@", object.objectId);
                NSString *movieOneWithChoice = object[@"movieOne"];
                NSString *movieOneChoice = [movieOneWithChoice substringToIndex:4];
                NSString *movieOneId = [movieOneWithChoice substringFromIndex:4];
                
                NSString *movieTwoWithChoice = object[@"movieTwo"];
                NSString *movieTwoChoice = [movieTwoWithChoice substringToIndex:4];
                NSString *movieTwoId = [movieTwoWithChoice substringFromIndex:4];
                
                NSString *movieThreeWithChoice = object[@"movieThree"];
                NSString *movieThreeChoice = [movieThreeWithChoice substringToIndex:4];
                NSString *movieThreeId = [movieThreeWithChoice substringFromIndex:4];
                
                if ([movieOneChoice isEqualToString:@"like"]) {
                    comparisonView.youMovieChoiceOne.image = [UIImage imageNamed: @"nav_like_button"];
                } else if ([movieOneChoice isEqualToString:@"nope"]) {
                    comparisonView.youMovieChoiceOne.image = [UIImage imageNamed: @"nav_nope_button"];
                }
                comparisonView.youMovieChoiceOne.alpha = 0.7f;

                if ([movieTwoChoice isEqualToString:@"like"]) {
                    comparisonView.youMovieChoiceTwo.image = [UIImage imageNamed: @"nav_like_button"];
                } else if ([movieTwoChoice isEqualToString:@"nope"]) {
                    comparisonView.youMovieChoiceTwo.image = [UIImage imageNamed: @"nav_nope_button"];
                }
                comparisonView.youMovieChoiceTwo.alpha = 0.7f;

                if ([movieThreeChoice isEqualToString:@"like"]) {
                    comparisonView.youMovieChoiceThree.image = [UIImage imageNamed: @"nav_like_button"];
                } else if ([movieThreeChoice isEqualToString:@"nope"]) {
                    comparisonView.youMovieChoiceThree.image = [UIImage imageNamed: @"nav_nope_button"];
                }
                comparisonView.youMovieChoiceThree.alpha = 0.7f;
                
                int i = 0;
                for (NSDictionary *movie in self.movies) {
                    if (movie[@"id"] == movieOneId) {
                        NSString *thumbnailString = movie[@"posters"][@"thumbnail"];
                        NSURL *url = [NSURL URLWithString:thumbnailString];
                        [comparisonView.youMovieOne setImageWithURL:url];
                    }
                    
                    if (movie[@"id"] == movieTwoId) {
                        NSString *thumbnailString = movie[@"posters"][@"thumbnail"];
                        NSURL *url = [NSURL URLWithString:thumbnailString];
                        [comparisonView.youMovieTwo setImageWithURL:url];
                    }
                    
                    if (movie[@"id"] == movieThreeId) {
                        NSString *thumbnailString = movie[@"posters"][@"thumbnail"];
                        NSURL *url = [NSURL URLWithString:thumbnailString];
                        [comparisonView.youMovieThree setImageWithURL:url];
                    }
                    
                    if (self.randOne == i) {
                        NSString *thumbnailString = movie[@"posters"][@"thumbnail"];
                        NSURL *url = [NSURL URLWithString:thumbnailString];
                        [comparisonView.matchMovieOne setImageWithURL:url];
                        if (self.randTwo < 10) {
                            comparisonView.matchMovieChoiceOne.image = [UIImage imageNamed: @"nav_like_button"];
                        } else {
                            comparisonView.matchMovieChoiceOne.image = [UIImage imageNamed: @"nav_nope_button"];
                        }
                        comparisonView.matchMovieChoiceOne.alpha = 0.7f;
                    }

                    if (self.randTwo == i) {
                        NSString *thumbnailString = movie[@"posters"][@"thumbnail"];
                        NSURL *url = [NSURL URLWithString:thumbnailString];
                        [comparisonView.matchMovieTwo setImageWithURL:url];
                        if (self.randThree < 10) {
                            comparisonView.matchMovieChoiceTwo.image = [UIImage imageNamed: @"nav_like_button"];
                        } else {
                            comparisonView.matchMovieChoiceTwo.image = [UIImage imageNamed: @"nav_nope_button"];
                        }
                        comparisonView.matchMovieChoiceTwo.alpha = 0.7f;
                    }

                    if (self.randThree == i) {
                        NSString *thumbnailString = movie[@"posters"][@"thumbnail"];
                        NSURL *url = [NSURL URLWithString:thumbnailString];
                        [comparisonView.matchMovieThree setImageWithURL:url];
                        if (self.randOne < 10) {
                            comparisonView.matchMovieChoiceThree.image = [UIImage imageNamed: @"nav_like_button"];
                        } else {
                            comparisonView.matchMovieChoiceThree.image = [UIImage imageNamed: @"nav_nope_button"];
                        }
                        comparisonView.matchMovieChoiceThree.alpha = 0.7f;
                    }

                    i = i+1;
                }

            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
        
        
        
        return comparisonView;
    } else {
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (void) scrollTableToBottomAnimated: (BOOL) animated {
    int rowNumber = [self.messagesTableView numberOfRowsInSection:1];
    if (rowNumber > 0) [self.messagesTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rowNumber-1 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
}

- (void) scrollTableToBottom {
    [self scrollTableToBottomAnimated: NO];
}

- (void) didTapOnTableView {
    [self.chatTextField resignFirstResponder];
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
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.messages.count - 1) inSection:1];
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
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.messages.count - 1) inSection:1];
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
