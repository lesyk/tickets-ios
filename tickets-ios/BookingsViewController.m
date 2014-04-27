//
//  TableViewController.m
//  tickets-ios
//
//  Created by Viktor Lesyk.
//  Copyright (c) 2014 Viktor Lesyk. All rights reserved.
//

#import "BookingsViewController.h"
#import "User.h"
#import "HTTPHelper.h"
#import "BookingViewController.h"

@interface BookingsViewController ()
@property NSMutableArray* users;
@end

@implementation BookingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [self.tableView setContentInset:UIEdgeInsetsMake(20,
                                                     self.tableView.contentInset.left,
                                                     self.tableView.contentInset.bottom,
                                                     self.tableView.contentInset.right)];
    [super viewDidLoad];
    self.users = [[NSMutableArray alloc] init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults valueForKey:@"token"];
    
    NSMutableString *url = [[NSMutableString alloc] initWithString:@"http://0.0.0.0:3000/bookings.json?auth_token="];
    [url appendString:token];
    
    NSString * response = [HTTPHelper getResponse:url];
    
    NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    for (int i = 0; i < jsonObject.count; i++) {
        User *user = [[User alloc] init];
        NSDictionary *curuser = [jsonObject objectAtIndex:i];
        user.firstName = [curuser objectForKey:@"title"];
        user.lastName = [curuser objectForKey:@"code"];
        [self.users addObject:user];
    }
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    User *curUser = (User *)[self.users objectAtIndex:indexPath.row];
    
    cell.textLabel.text = curUser.firstName;
    cell.detailTextLabel.text = curUser.lastName;
    
    return cell;
}

#pragma mark - Table view delegate

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue.destinationViewController setBookingNumber:@"name222"];
}

@end
