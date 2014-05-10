//
//  SearchResultViewController.h
//  tickets-ios
//
//  Created by Victor Lesyk on 5/9/14.
//
//

#import <UIKit/UIKit.h>

@interface SearchResultViewController : UIViewController

@property (strong, nonatomic) NSString *code;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) NSString *date;

@property (weak, nonatomic) IBOutlet UILabel *date_backLabel;
@property (strong, nonatomic) NSString *date_back;

@property (weak, nonatomic) IBOutlet UILabel *routeLabel;
@property (strong, nonatomic) NSString *from;
@property (strong, nonatomic) NSString *to;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) NSString *price;



- (IBAction)bookAction:(id)sender;
@end