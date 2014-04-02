//
//  HTTPHelper.h
//  SimpleTable
//
//  Created by DX123-XL on 2014-01-07.
//  Copyright (c) 2014 DX123-XL. All rights reserved.
//

@interface HTTPHelper : NSObject

+ (NSString *) getResponse: (NSString*)input;
+ (NSString *) postResponse: (NSString*)input;
@end