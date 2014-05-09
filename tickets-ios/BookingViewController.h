//
//  BookingViewController.h
//  tickets-ios
//
//  Created by Victor Lesyk on 4/27/14.
//
//

#import <UIKit/UIKit.h>

@interface BookingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (strong, nonatomic) NSString *code;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) NSString *date;

@property (weak, nonatomic) IBOutlet UILabel *date_backLabel;
@property (strong, nonatomic) NSString *date_back;

@property (weak, nonatomic) IBOutlet UILabel *routeLabel;
@property (strong, nonatomic) NSString *route;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) NSString *price;

- (IBAction)removeBookingAction:(id)sender;
@end
