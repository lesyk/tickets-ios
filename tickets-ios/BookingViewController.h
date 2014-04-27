//
//  BookingViewController.h
//  tickets-ios
//
//  Created by Victor Lesyk on 4/27/14.
//
//

#import <UIKit/UIKit.h>

@interface BookingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *bookingNumberLabel;
@property (strong, nonatomic) NSString *bookingNumber;

@end
