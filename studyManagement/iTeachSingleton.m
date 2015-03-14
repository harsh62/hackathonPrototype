//
//  iTeachSingleton.m
//  studyManagement
//
//  Created by skapoor on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import "iTeachSingleton.h"

@implementation iTeachSingleton
static iTeachSingleton* _sharedMySingleton = nil;

//+(iTeachSingleton*)sharedMySingleton {
//    
//    @synchronized([iTeachSingleton class]) {
//        if (!_sharedMySingleton) {
//            _sharedMySingleton = [[self alloc] init];
//            return _sharedMySingleton;
//        }
//        return nil;
//    }
//}

+ (id)sharedManager {
    static iTeachSingleton *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

@end
