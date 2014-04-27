//
//  HTTPHelper.h
//  SimpleTable
//
//  Based on DX123-XL on 2014-01-07.
//

#import "HTTPHelper.h"

static NSString *const host = @"http://0.0.0.0:3000/";

@implementation HTTPHelper

+ (NSString *) getResponse:(NSString *)input{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];

    NSMutableString *url = [[NSMutableString alloc] initWithString:@""];
    [url appendString:host];
    [url appendString:input];
    [request setURL:[NSURL URLWithString:url]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", input, [responseCode statusCode]);
        return nil;
    }
    
    NSString* tResponse = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    NSString *trimmedResponse = [tResponse stringByTrimmingCharactersInSet:
                                 [NSCharacterSet newlineCharacterSet]];
    return trimmedResponse;
}

+ (NSString *) postResponse:(NSString *)input{
    NSError *error;
    
    NSMutableString *url = [[NSMutableString alloc] initWithString:@""];
    [url appendString:host];
    [url appendString:input];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setTimeoutInterval:60.0];
    [request setURL:[NSURL URLWithString:url]];
    
    NSArray *objects = [NSArray arrayWithObjects:@"password",@"lesyk.victor@gmail.com",  nil];
    NSArray *keys = [NSArray arrayWithObjects:@"password",@"email", nil];
    NSDictionary *questionDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSDictionary *mapData = [NSDictionary dictionaryWithObject:questionDict forKey:@"user"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
    [request setHTTPBody:postData];
    
//    if(request){
//        NSLog(@"%@", request);
//    }
    
    NSHTTPURLResponse *responseCode = nil;
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", input, [responseCode statusCode]);
        return nil;
    }
    
    NSString* tResponse = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    NSString *trimmedResponse = [tResponse stringByTrimmingCharactersInSet:
                                 [NSCharacterSet newlineCharacterSet]];
    
//    NSLog(@"%@", trimmedResponse);
    return trimmedResponse;
}

@end