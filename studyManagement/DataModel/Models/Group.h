//
//  Group.h
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Users;

@interface Group : NSManagedObject

@property (nonatomic, retain) NSString * groupId;
@property (nonatomic, retain) NSSet *hasUsers;
@end

@interface Group (CoreDataGeneratedAccessors)

- (void)addHasUsersObject:(Users *)value;
- (void)removeHasUsersObject:(Users *)value;
- (void)addHasUsers:(NSSet *)values;
- (void)removeHasUsers:(NSSet *)values;

@end
