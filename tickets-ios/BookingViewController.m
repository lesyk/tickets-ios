//
//  BookingViewController.m
//  tickets-ios
//
//  Created by Victor Lesyk on 4/27/14.
//
//

#import "BookingViewController.h"
#import "BookingsViewController.h"
#import "HTTPHelper.h"

@interface BookingViewController ()
@end

@implementation BookingViewController

@synthesize codeLabel, code, route, routeLabel, price, priceLabel, date, dateLabel, date_back, date_backLabel;

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
    codeLabel.text = code;
    priceLabel.text = price;
    dateLabel.text = date;
    date_backLabel.text = date_back;
    routeLabel.text = route;
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

- (IBAction)removeBookingAction:(id)sender {
    NSArray *objects = [NSArray arrayWithObjects:self.code, nil];
    NSArray *keys = [NSArray arrayWithObjects:@"id", nil];
    NSDictionary *questionDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSDictionary *mapData = [NSDictionary dictionaryWithObject:questionDict forKey:@"user"];
    NSMutableString *url = [[NSMutableString alloc] initWithString:@"/bookings/"];
    [url appendString:self.code];
    NSString * response = [HTTPHelper postResponse:url withMapData:mapData method:@"DELETE"];
    
    if(!response){
        BookingsViewController *bookingsView = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
        [self presentViewController:bookingsView animated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error occured"
                                                        message:@"Deletion failed."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        NSLog(@"Error!");
        [alert show];
    }
}
@end
