//
//  SearchViewController.h
//  tickets-ios
//
//  Created by Victor Lesyk on 5/8/14.
//
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *fromInput;
@property (weak, nonatomic) IBOutlet UITextField *toInput;
@property (weak, nonatomic) IBOutlet UITextField *dateInput;
@property (weak, nonatomic) IBOutlet UITextField *date_backInput;

@end