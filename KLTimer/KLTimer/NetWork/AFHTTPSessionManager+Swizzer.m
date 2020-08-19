//
//  AFHTTPSessionManager+Swizzer.m
//  KLTimer
//
//  Created by WKL on 2019/11/13.
//  Copyright © 2019 Ray. All rights reserved.
//

#import "AFHTTPSessionManager+Swizzer.h"

 

@implementation AFHTTPSessionManager (Swizzer)

-(void)dd {
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@""]] ;
    [request setHTTPMethod:@"POST"];
    
    
    NSString *bodyStr = @"k=ddd&k2=dfdf";
    [request setHTTPBody:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLSession *sesstion = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    
  NSURLSessionDataTask *task =  [sesstion dataTaskWithRequest:request] ;
    
    [task resume];
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    
}

@end
