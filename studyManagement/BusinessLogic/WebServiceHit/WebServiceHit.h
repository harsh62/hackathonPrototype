//
//  WebServiceHit.h
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServiceHit : NSObject
+ (NSData *)hitTheServerWithURLRequest:(NSURLRequest *)urlRequest;
@end
