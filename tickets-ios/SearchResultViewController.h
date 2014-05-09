//
//  SearchResultViewController.h
//  tickets-ios
//
//  Created by Victor Lesyk on 5/9/14.
//
//

#import <UIKit/UIKit.h>

@interface SearchResultViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *routeLabel;
@property (strong, nonatomic) NSString *route;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) NSString *price;

- (IBAction)bookAction:(id)sender;
@end