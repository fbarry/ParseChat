//
//  LoginViewController.m
//  ParseChat
//
//  Created by Fiona Barry on 7/6/20.
//  Copyright © 2020 fbarry. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "Utilities.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.activityIndicator setHidden:YES];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapSignup:(id)sender {
    if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]) {
        // Fields are empty
        [Utilities presentOkAlertControllerInViewController:self
                                                  withTitle:@"Invalid Input"
                                                    message:@"Username/Password field is incomplete."];
    } else {
        [self.activityIndicator startAnimating];
        
        PFUser *user = [PFUser user];
        
        user.username = self.usernameField.text;
        user.password = self.passwordField.text;
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (error) {
                // Print error code
                [Utilities presentOkAlertControllerInViewController:self
                                                          withTitle:@"Error Creating User"
                                                            message:[NSString stringWithFormat:@"%@", error.localizedDescription]];
            } else {
                [self performSegueWithIdentifier:@"LoginSegue" sender:self];
            }
            [self.activityIndicator stopAnimating];
        }];
    }
}

- (IBAction)didTapLogin:(id)sender {
    [self.activityIndicator startAnimating];
    
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * _Nullable user, NSError * _Nullable error) {
        if (error) {
            [Utilities presentOkAlertControllerInViewController:self
                                                      withTitle:@"Error Logging In"
                                                        message:[NSString stringWithFormat:@"%@", error.localizedDescription]];
        } else {
            [self performSegueWithIdentifier:@"LoginSegue" sender:self];
        }
        [self.activityIndicator startAnimating];
    }];
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
