//
//  CalendarManager.m
//  StrikR
//
//  Created by Julien MARTRES on 20/09/13.
//  Copyright (c) 2013 Mickael Alléon. All rights reserved.
//

#import "CalendarManager.h"

@implementation CalendarManager
@synthesize matchOfTheWeek;
@synthesize datesOfTheWeek;





+ (id)sharedManager {
static CalendarManager *sharedMyManager = nil;
static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{
    sharedMyManager = [[self alloc] init];
});
    
return sharedMyManager;
}


- (id)init {
    if (self = [super init]) {
        matchOfTheWeek = [[NSMutableArray alloc] init];
        datesOfTheWeek = [[NSMutableArray alloc] init];
        
        
    }
    return self;
}


@end
