//
//  CalendarManager.h
//  StrikR
//
//  Created by Julien MARTRES on 20/09/13.
//  Copyright (c) 2013 Mickael Alléon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarManager: NSObject {
    
    NSMutableArray *matchOfTheWeek;
    NSMutableArray *datesOfTheWeek;
    
}

@property (nonatomic, strong) NSMutableArray *matchOfTheWeek;
@property (nonatomic, strong) NSMutableArray *datesOfTheWeek;

+ (id)sharedManager;
@end
