//
//  LogInSignUp.h
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerResponseProtocol.h"
@interface LogInSignUp : NSObject<logInSignUpProtocol>


- (BOOL)tryToLogInWithUserName:(NSString *)userName Password:(NSString *)password;
- (BOOL)tryToSignUpWithUserName:(NSString *)userName Password:(NSString *)password andGroupId:(NSString *)groupId;


@end
