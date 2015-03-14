//
//  addClassViewController.h
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavProtocol.h"

typedef enum {
    StudentSelected,
    TeacherSelected,
    SubjectSelected,
    StandardSelected
} ButtonSelected;

@interface addClassViewController : UITableViewController <modalControllerDelegate>
{
    ButtonSelected selectedButton;
}
@property (weak, nonatomic) IBOutlet UIButton *showStandardDataSelected;
@property (strong, nonatomic) NSArray *selectedStudents;
@property (strong, nonatomic) NSArray *selectedTeachers;
@property (strong, nonatomic) NSArray *selectedSubjects;
@end
