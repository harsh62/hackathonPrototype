//
//  WebServiceHit.m
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import "WebServiceHit.h"

@implementation WebServiceHit

+ (NSData *)hitTheServerWithURLRequest:(NSURLRequest *)urlRequest{
    
    NSError *errorReturned = nil;
    NSURLResponse *theResponse =[[NSURLResponse alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                         returningResponse:&theResponse
                                                     error:&errorReturned];
    
    if (errorReturned)
    {
        //...handle the error
    }
    else
    {
//        NSString *retVal = [[NSString alloc] initWithData:data
//                                                 encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", retVal);
        
    }
    return  data;
    
}

@end
