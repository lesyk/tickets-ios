//
//  SearchViewController.m
//  tickets-ios
//
//  Created by Victor Lesyk on 5/8/14.
//
//

#import "SearchViewController.h"
#import "HTTPHelper.h"
#import "Booking.h"
#import "SearchTableViewController.h"

@interface SearchViewController ()
@property NSMutableArray* searchResults;
@end

@implementation SearchViewController
@synthesize toInput, fromInput, searchResults, date_backInput, dateInput;

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
    if ([toInput isFirstResponder] && [touch view] != toInput) {
        [toInput resignFirstResponder];
    }
    if ([fromInput isFirstResponder] && [touch view] != fromInput) {
        [fromInput resignFirstResponder];
    }
    if ([dateInput isFirstResponder] && [touch view] != dateInput) {
        [dateInput resignFirstResponder];
    }
    if ([date_backInput isFirstResponder] && [touch view] != date_backInput) {
        [date_backInput resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"openSearchResults"])
    {
        NSArray *objects = [NSArray arrayWithObjects:toInput.text,fromInput.text,dateInput.text,date_backInput.text,  nil];
        NSArray *keys = [NSArray arrayWithObjects:@"to",@"from",@"date",@"date_back", nil];
        NSDictionary *mapData = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *token = [defaults valueForKey:@"token"];
        
        NSMutableString *url = [[NSMutableString alloc] initWithString:@"/search/index.json?auth_token="];
        [url appendString:token];
        
        NSString * response = [HTTPHelper postResponse:url withMapData:mapData method:@"POST"];
        
        self.searchResults = [[NSMutableArray alloc] init];
        
        if(response){
            NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            for (int i = 0; i < jsonObject.count; i++) {
                Booking *search = [[Booking alloc] init];
                NSDictionary *curuser = [jsonObject objectAtIndex:i];
                
                search.price = [curuser objectForKey:@"MinPrice"];
                search.from = [[curuser objectForKey:@"OutboundLeg"] objectForKey:@"OriginId"];
                search.to = [[curuser objectForKey:@"InboundLeg"] objectForKey:@"OriginId"];
                search.date = @"2014-06-06";
                search.date_back = @"2014-06-06";
                [self.searchResults addObject:search];
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error occured"
                                                            message:@"Search failed."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            NSLog(@"Error!");
            [alert show];
        }
        SearchTableViewController *stvc = [segue destinationViewController];
        [stvc setSearchResults:self.searchResults];
    }
}

- (IBAction)lookupDirectionsAction:(id)sender {
    NSArray *objects = [NSArray arrayWithObjects:@"message", @"5",  nil];
    NSArray *keys = [NSArray arrayWithObjects:@"message",@"number", nil];
    NSDictionary *mapData = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults valueForKey:@"token"];
    
    NSMutableString *url = [[NSMutableString alloc] initWithString:@"/search/lookup_directions.json?auth_token="];
    [url appendString:token];
    
    NSString * response = [HTTPHelper postResponse:url withMapData:mapData method:@"POST"];
    
    self.searchResults = [[NSMutableArray alloc] init];
    
    if(response){
        NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSString *message = [jsonObject objectForKey:@"message"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Server answer"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error occured"
                                                        message:@"Search failed."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        NSLog(@"Error!");
        [alert show];
    }
}
@end