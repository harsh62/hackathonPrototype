//
//  iTeachSingleton.h
//  studyManagement
//
//  Created by skapoor on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iTeachSingleton : NSObject

@property (strong, nonatomic) NSString *userName;



//+(iTeachSingleton*)sharedMySingleton;
+ (id)sharedManager;
@end
