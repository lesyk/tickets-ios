//
//  TableViewController.m
//  tickets-ios
//
//  Created by Viktor Lesyk.
//  Copyright (c) 2014 Viktor Lesyk. All rights reserved.
//

#import "BookingsViewController.h"
#import "Booking.h"
#import "HTTPHelper.h"
#import "BookingViewController.h"

@interface BookingsViewController ()
@property NSMutableArray* bookings;
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
    self.bookings = [[NSMutableArray alloc] init];
    [self refreshData];
    [self.tableView reloadData];
    
}

- (void)refreshData
{
    [self.bookings removeAllObjects];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults valueForKey:@"token"];
    
    NSMutableString *url = [[NSMutableString alloc] initWithString:@"/bookings.json?auth_token="];
    [url appendString:token];
    
    NSString * response = [HTTPHelper getResponse:url];
    
    NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    for (int i = 0; i < jsonObject.count; i++) {
        Booking *b = [[Booking alloc] init];
        NSDictionary *curuser = [jsonObject objectAtIndex:i];
        b.price = [curuser objectForKey:@"price"];
        b.code = [[curuser objectForKey:@"id"] stringValue];

//        NSMutableString *route = [[NSMutableString alloc] initWithString:@""];
//        [route appendString:[curuser objectForKey:@"from"]];
//        [route appendString:@" - "];
//        [route appendString:[curuser objectForKey:@"to"]];
        
        b.from = [curuser objectForKey:@"from"];
        b.to = [curuser objectForKey:@"to"];
        b.date = [curuser objectForKey:@"date"];
        b.date_back = [curuser objectForKey:@"date_back"];
        [self.bookings addObject:b];
    }
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
    return self.bookings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    Booking *curB = (Booking *)[self.bookings objectAtIndex:indexPath.row];
    
    NSMutableString *route = [[NSMutableString alloc] initWithString:@""];
    [route appendString:curB.from];
    [route appendString:@" - "];
    [route appendString:curB.to];
    
    cell.textLabel.text = route;
    cell.detailTextLabel.text = curB.code;
    
    return cell;
}

#pragma mark - Table view delegate

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"openBooking"])
    {
        BookingViewController *srvc = [segue destinationViewController];
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        long row = [myIndexPath row];
        Booking *a = self.bookings[row];
        
        NSMutableString *route = [[NSMutableString alloc] initWithString:@""];
        [route appendString:[NSString stringWithFormat:@"%@",a.from]];
        [route appendString:@" - "];
        [route appendString:[NSString stringWithFormat:@"%@",a.to]];
        [srvc setRoute:[NSString stringWithFormat:@"%@",route]];
        
        [srvc setPrice:[NSString stringWithFormat:@"%@",a.price]];
        [srvc setDate:[NSString stringWithFormat:@"%@",a.date]];
        [srvc setDate_back:[NSString stringWithFormat:@"%@",a.date_back]];
        [srvc setCode:[NSString stringWithFormat:@"%@",a.code]];
    }
}

- (IBAction)reloadData:(id)sender {
    [self refreshData];
    [self.tableView reloadData];
}
@end
