//
//  HTTPHelper.h
//  SimpleTable
//
//  Based on DX123-XL on 2014-01-07.
//

@interface HTTPHelper : NSObject

+ (NSString *) getResponse: (NSString*)input;
+ (NSString *) postResponse:(NSString *)input withMapData:(NSDictionary *)mapData;
+ (NSString *) putResponse:(NSString *)input withMapData:(NSDictionary *)mapData;

@end