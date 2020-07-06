//
//  ChatViewController.m
//  ParseChat
//
//  Created by Fiona Barry on 7/6/20.
//  Copyright © 2020 fbarry. All rights reserved.
//

#import "ChatViewController.h"
#import <Parse/Parse.h>
#import "Utilities.h"
#import "ChatCell.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *messages;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refresh) userInfo:nil repeats:true];
    
    self.tableView.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
}

- (void)refresh {
    PFQuery *query = [PFQuery queryWithClassName:@"Message_fbu2020"];
    [query includeKey:@"user"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error with query");
        } else {
            self.messages = objects;
            [self.tableView reloadData];
        }
        [self.tableView.refreshControl endRefreshing];
    }];
}

- (IBAction)didTapSend:(id)sender {
    if (![self.messageField.text isEqual:@""]) {
        PFObject *chatMessage = [PFObject objectWithClassName:@"Message_fbu2020"];
        chatMessage[@"text"] = self.messageField.text;
        chatMessage[@"user"] = [PFUser currentUser];
        
        [chatMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error) {
                [Utilities presentOkAlertControllerInViewController:self
                                                          withTitle:@"Error Sending Message"
                                                            message:[NSString stringWithFormat:@"%@", error.localizedDescription]];
            } else {
                self.messageField.text = nil;
            }
        }];
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ChatCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ChatCell"];
    PFObject *message = self.messages[indexPath.row];
    cell.messageLabel.text = message[@"text"];
    
    PFUser *user = message[@"user"];
    if (user) {
        cell.usernameLabel.text = user.username;
        [cell.avatar setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.adorable.io/avatars/285/%@.png", user.username]] ];
    } else {
        cell.usernameLabel.text = @"Anonymous";
        [cell.avatar setImageWithURL:[NSURL URLWithString:@"https://api.adorable.io/avatars/285/anonymous.png"]];
    }
        
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (IBAction)didTapLogout:(id)sender {
    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    sceneDelegate.window.rootViewController = loginViewController;

    [PFUser logOut];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
