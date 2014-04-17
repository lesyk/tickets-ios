//
//  LoginViewController.m
//  tickets-ios
//
//  Created by Victor Lesyk on 4/2/14.
//  Copyright (c) 2014 Viktor Lesyk. All rights reserved.
//

#import "LoginViewController.h"
#import "HTTPHelper.h"
#import "TableViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginAction;

@end

@implementation LoginViewController

- (IBAction)loginAction:(id)sender{
    
    NSString * response = [HTTPHelper postResponse:@"http://0.0.0.0:3000/users/sign_in"];

    if(response){
        NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error=nil;
        NSDictionary *aaa=[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:&error];
        NSString* sth=[aaa objectForKey: @"auth_token"];

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:sth forKey:@"token"];
//        NSLog(@"dddd %@", [defaults valueForKey:@"token"]);
        
        
        TableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TableView"];
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        NSLog(@"Error!");
    }
}


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
@end
