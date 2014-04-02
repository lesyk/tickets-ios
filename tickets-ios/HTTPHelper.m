#import "HTTPHelper.h"

@implementation HTTPHelper

+ (NSString *) getResponse:(NSString *)input{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:input]];
    
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
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setHTTPMethod:@"POST"];
//    [request setURL:[NSURL URLWithString:input]];
//    NSString *postString = @"email='lesyk.victor@gmail.com'&password='password'";
//    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    NSError *error = [[NSError alloc] init];
//    NSHTTPURLResponse *responseCode = nil;
//    
//    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
//    
//    if([responseCode statusCode] != 200){
//        NSLog(@"Error getting %@, HTTP status code %i", input, [responseCode statusCode]);
//        return nil;
//    }
//    
//    NSString* tResponse = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
//    NSString *trimmedResponse = [tResponse stringByTrimmingCharactersInSet:
//                                 [NSCharacterSet newlineCharacterSet]];
//    return trimmedResponse;
    
    NSError *error;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:input];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    
    NSArray *objects = [NSArray arrayWithObjects:@"password",@"lesyk.victor@gmail.com",  nil];
    NSArray *keys = [NSArray arrayWithObjects:@"password",@"email", nil];
    NSDictionary *questionDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSDictionary *mapData = [NSDictionary dictionaryWithObject:questionDict forKey:@"user"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
    [request setHTTPBody:postData];
    
//    if(request){
//        NSLog(@"%@", request);
//    }
    
//    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    
//    }];
    
//    [postDataTask resume];
    
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