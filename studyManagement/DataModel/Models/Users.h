//
//  Users.h
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Users : NSManagedObject

@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSSet *hasSubjects;
@property (nonatomic, retain) NSSet *hasClasses;
@property (nonatomic, retain) NSSet *hasStudents;
@property (nonatomic, retain) NSManagedObject *inGroup;
@end

@interface Users (CoreDataGeneratedAccessors)

- (void)addHasSubjectsObject:(NSManagedObject *)value;
- (void)removeHasSubjectsObject:(NSManagedObject *)value;
- (void)addHasSubjects:(NSSet *)values;
- (void)removeHasSubjects:(NSSet *)values;

- (void)addHasClassesObject:(NSManagedObject *)value;
- (void)removeHasClassesObject:(NSManagedObject *)value;
- (void)addHasClasses:(NSSet *)values;
- (void)removeHasClasses:(NSSet *)values;

- (void)addHasStudentsObject:(NSManagedObject *)value;
- (void)removeHasStudentsObject:(NSManagedObject *)value;
- (void)addHasStudents:(NSSet *)values;
- (void)removeHasStudents:(NSSet *)values;

@end
