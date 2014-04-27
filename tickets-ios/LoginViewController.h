//
//  LoginViewController.h
//  tickets-ios
//
//  Created by Victor Lesyk on 4/2/14.
//  Copyright (c) 2014 Viktor Lesyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)loginAction:(id)sender;

@end
