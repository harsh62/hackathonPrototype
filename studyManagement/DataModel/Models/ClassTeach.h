//
//  ClassTeach.h
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Students, Subjects, Users;

@interface ClassTeach : NSManagedObject

@property (nonatomic, retain) NSString * teachClassName;
@property (nonatomic, retain) NSString * teachClassStandard;
@property (nonatomic, retain) NSSet *hasUsers;
@property (nonatomic, retain) NSSet *hasStudents;
@property (nonatomic, retain) NSSet *hasSubjects;
@end

@interface ClassTeach (CoreDataGeneratedAccessors)

- (void)addHasUsersObject:(Users *)value;
- (void)removeHasUsersObject:(Users *)value;
- (void)addHasUsers:(NSSet *)values;
- (void)removeHasUsers:(NSSet *)values;

- (void)addHasStudentsObject:(Students *)value;
- (void)removeHasStudentsObject:(Students *)value;
- (void)addHasStudents:(NSSet *)values;
- (void)removeHasStudents:(NSSet *)values;

- (void)addHasSubjectsObject:(Subjects *)value;
- (void)removeHasSubjectsObject:(Subjects *)value;
- (void)addHasSubjects:(NSSet *)values;
- (void)removeHasSubjects:(NSSet *)values;

@end
