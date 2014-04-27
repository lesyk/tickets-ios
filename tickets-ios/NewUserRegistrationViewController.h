//
//  RegistrationViewController.h
//  tickets-ios
//
//  Created by Victor Lesyk on 4/27/14.
//
//

#import <UIKit/UIKit.h>

@interface NewUserRegistrationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmationField;

- (IBAction)registrationAction:(id)sender;

@end
