//
//  EditUserViewController.h
//  tickets-ios
//
//  Created by Victor Lesyk on 4/27/14.
//
//

#import <UIKit/UIKit.h>

@interface EditUserRegistrationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmationField;
@property (weak, nonatomic) IBOutlet UITextField *currentPasswordField;

- (IBAction)save:(id)sender;

@end
