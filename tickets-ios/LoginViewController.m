//
//  LoginViewController.m
//  tickets-ios
//
//  Created by Victor Lesyk on 4/2/14.
//  Copyright (c) 2014 Viktor Lesyk. All rights reserved.
//

#import "LoginViewController.h"
#import "HTTPHelper.h"
#import "BookingsViewController.h"

@implementation LoginViewController
@synthesize emailField, passwordField;

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
    if ([passwordField isFirstResponder] && [touch view] != passwordField) {
        [passwordField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)loginAction:(id)sender{
    
    NSArray *objects = [NSArray arrayWithObjects:passwordField.text,emailField.text,  nil];
    NSArray *keys = [NSArray arrayWithObjects:@"password",@"email", nil];
    NSDictionary *questionDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSDictionary *mapData = [NSDictionary dictionaryWithObject:questionDict forKey:@"user"];
    NSString * response = [HTTPHelper postResponse:@"/users/sign_in" withMapData:mapData method:@"POST"];
    
    if(response){
        NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error=nil;
        NSDictionary *aaa=[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:&error];
        NSString* sth=[aaa objectForKey: @"auth_token"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:sth forKey:@"token"];
        //        NSLog(@"dddd %@", [defaults valueForKey:@"token"]);
        
        BookingsViewController *bookingsView = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
        [self presentViewController:bookingsView animated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error occured"
                                                        message:@"Login failed."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        NSLog(@"Error!");
        [alert show];
    }
}

@end
