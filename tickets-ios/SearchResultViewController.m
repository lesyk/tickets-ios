//
//  SearchResultViewController.m
//  tickets-ios
//
//  Created by Victor Lesyk on 5/9/14.
//
//

#import "SearchResultViewController.h"
#import "HTTPHelper.h"
#import "BookingsViewController.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

@synthesize code, from, to, routeLabel, price, priceLabel, date, dateLabel, date_back, date_backLabel;

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

    NSMutableString *route = [[NSMutableString alloc] initWithString:@""];
    [route appendString:[NSString stringWithFormat:@"%@",self.from]];
    [route appendString:@" - "];
    [route appendString:[NSString stringWithFormat:@"%@",self.to]];

    routeLabel.text = route;
    priceLabel.text = price;
    dateLabel.text = date;
    date_backLabel.text = date_back;
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

- (IBAction)bookAction:(id)sender {
    NSArray *objects = [NSArray arrayWithObjects:from, to, date, date_back, price,  nil];
    NSArray *keys = [NSArray arrayWithObjects:@"from", @"to", @"date", @"date_back", @"price", nil];
    NSDictionary *questionDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSDictionary *mapData = [NSDictionary dictionaryWithObject:questionDict forKey:@"booking"];
    NSString * response = [HTTPHelper postResponse:@"/bookings" withMapData:mapData method:@"POST"];
    
    if(response){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                        message:@"Booking was created."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        BookingsViewController *b = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
        [self presentViewController:b animated:YES completion:nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error occured"
                                                        message:@"Booking wasn't created."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        NSLog(@"Error!");
        [alert show];
    }
}
@end
