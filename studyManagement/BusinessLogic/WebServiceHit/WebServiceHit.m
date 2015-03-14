//
//  WebServiceHit.m
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import "WebServiceHit.h"

@implementation WebServiceHit

+ (NSArray *)hitTheServerWithURLRequest:(NSURLRequest *)urlRequest{
    
    NSError *errorReturned = nil;
    NSURLResponse *theResponse =[[NSURLResponse alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                         returningResponse:&theResponse
                                                     error:&errorReturned];
    NSArray *jsonArray = [[NSArray alloc] init];
    if (errorReturned)
    {
        //...handle the error
    }
    else
    {
         jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
    }
    return  jsonArray;
    
}

@end
