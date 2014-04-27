//
//  EditUserViewController.m
//  tickets-ios
//
//  Created by Victor Lesyk on 4/27/14.
//
//

#import "EditUserRegistrationViewController.h"
#import "HTTPHelper.h"

@interface EditUserRegistrationViewController ()

@end

@implementation EditUserRegistrationViewController
@synthesize emailField, passwordField, currentPasswordField, passwordConfirmationField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([emailField isFirstResponder] && [touch view] != emailField) {
        [emailField resignFirstResponder];
    }
    if ([currentPasswordField isFirstResponder] && [touch view] != currentPasswordField) {
        [currentPasswordField resignFirstResponder];
    }
    if ([passwordField isFirstResponder] && [touch view] != passwordField) {
        [passwordField resignFirstResponder];
    }
    if ([passwordConfirmationField isFirstResponder] && [touch view] != passwordConfirmationField) {
        [passwordConfirmationField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)save:(id)sender {
    NSArray *objects = [NSArray arrayWithObjects:currentPasswordField.text, passwordField.text, passwordConfirmationField.text, emailField.text,  nil];
    NSArray *keys = [NSArray arrayWithObjects:@"current_password", @"password_confirmation", @"password", @"email", nil];
    NSDictionary *questionDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSDictionary *mapData = [NSDictionary dictionaryWithObject:questionDict forKey:@"user"];
    NSString * response = [HTTPHelper putResponse:@"/users" withMapData:mapData];
    
    if(response){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                        message:@"Account was updated."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error occured"
                                                        message:@"Account wasn't updated."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        NSLog(@"Error!");
        [alert show];
    }
}
@end