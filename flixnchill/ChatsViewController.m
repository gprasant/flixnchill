//
//  ChatsViewController.m
//  tinder
//
//  Created by Prasanth Guruprasad on 11/21/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "ChatsViewController.h"
#import "ChatViewController.h"
#import "PotentialMatch.h"
#import "User.h"
#import "ChatTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface ChatsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *chatsTableView;

@property (strong, nonatomic) PotentialMatch *selectedUser;
@end

@implementation ChatsViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	UIColor *netflixRed = [UIColor colorWithRed:(185/255.0) green:(9/255.0) blue:(11/255.0) alpha:1] ;
	self.view.backgroundColor = netflixRed;
	[self setupTableView];
	[self setNeedsStatusBarAppearanceUpdate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBackTapped:(UITapGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqual:@"chatSegue"] ) {
        ChatViewController *vc = (ChatViewController *)[segue destinationViewController];
        // Use sender._nameLabel._content here for the chatWithUserName.
        vc.chatWith = [sender match];
    }
}


#pragma mark - BEGIN TableView Methods
- (void) setupTableView {
    self.chatsTableView.delegate = self;
    self.chatsTableView.dataSource = self;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[[User currentUser] matches] count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell"];
	PotentialMatch *match = [[[User currentUser] matches] objectAtIndex:indexPath.row];
    cell.match = match;
    cell.nameLabel.text = match.name;
    
	[cell.matchImageView setImageWithURL:[NSURL URLWithString:match.photoUrlString]];
	return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedUser = [[[User currentUser] matches] objectAtIndex:indexPath.row];

//    present ChatViewController here 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
	return UIStatusBarStyleLightContent;
}

#pragma mark - END TableView Methods

@end
