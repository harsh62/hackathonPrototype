//
//  LogInSignUp.m
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import "LogInSignUp.h"
#import "WebServiceHit.h"

@implementation LogInSignUp

- (void)tryToSignUpWithUserName:(NSString *)userName Password:(NSString *)password andGroupId:(NSString *)groupId{

    NSMutableDictionary *dictionnary = [NSMutableDictionary dictionary];
    [dictionnary setObject:userName forKey:@"volunteerId"];
    [dictionnary setObject:password forKey:@"password"];
    [dictionnary setObject:groupId forKey:@"groupId"];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionnary
                                                       options:kNilOptions
                                                         error:&error];
    
    NSString *urlString = @"http://localhost:8080/ListrWS.asmx/LogIn";
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Prepare the request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"json" forHTTPHeaderField:@"Data-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsonData length]]  forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:jsonData];
    
    [WebServiceHit hitTheServerWithURLRequest:request];
    
}


- (void)tryToLogInWithUserName:(NSString *)userName Password:(NSString *)password{
    
    NSMutableDictionary *dictionnary = [NSMutableDictionary dictionary];
    [dictionnary setObject:userName forKey:@"userId"];
    [dictionnary setObject:password forKey:@"password"];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionnary
                                                       options:kNilOptions
                                                         error:&error];
    
    NSString *urlString = @"http://localhost:8080/ListrWS.asmx/LogIn";
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Prepare the request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"json" forHTTPHeaderField:@"Data-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsonData length]]  forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:jsonData];
    
    [WebServiceHit hitTheServerWithURLRequest:request];
    
}

@end
