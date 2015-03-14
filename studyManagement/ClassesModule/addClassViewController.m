//
//  addClassViewController.m
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import "addClassViewController.h"
#import "standardClassesSelectionTableViewController.h"
#import "ShowStudentTableViewController.h"
#import "ShowSubjectsTableViewController.h"
#import "ShowTeacherTableViewController.h"

@interface addClassViewController ()

@end

@implementation addClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectedStudents = [[NSMutableArray alloc] init];
    self.selectedTeachers = [[NSMutableArray alloc] init];
    self.selectedSubjects = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    self.numberOfStudents.text = [NSString stringWithFormat:@"Number Of Students: %lu",(unsigned long)[self.selectedStudents count]];
    self.numberOfTeachers.text = [NSString stringWithFormat:@"Number Of Teachers: %lu",(unsigned long)[self.selectedTeachers count]];
    self.numberOfSubjects.text = [NSString stringWithFormat:@"Number Of Subjects: %lu",(unsigned long)[self.selectedSubjects count]];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"standardSegue"]){
        standardClassesSelectionTableViewController *standardSelectionController = [segue destinationViewController];
        standardSelectionController.modalNavigationDelegate = self;
        selectedButton = StandardSelected;
    }
    else if([segue.identifier isEqualToString:@"studentSegue"]){
        ShowStudentTableViewController *showStudentViewcontroller = [segue destinationViewController];
        showStudentViewcontroller.modalNavigationDelegate = self;
        showStudentViewcontroller.selectedStudents = self.selectedStudents;
        selectedButton = StudentSelected;
    }
    else if([segue.identifier isEqualToString:@"teachersSegue"]){
        ShowTeacherTableViewController *showStudentViewcontroller = [segue destinationViewController];
        showStudentViewcontroller.modalNavigationDelegate = self;
        showStudentViewcontroller.selectedTeachers = self.selectedTeachers;
        selectedButton = TeacherSelected;
    }
    else if([segue.identifier isEqualToString:@"subjectsSegue"]){
        ShowSubjectsTableViewController *showStudentViewcontroller = [segue destinationViewController];
        showStudentViewcontroller.modalNavigationDelegate = self;
        showStudentViewcontroller.selectedSubjects = self.selectedSubjects;
        selectedButton = SubjectSelected;
    }

}

- (void)modalControllerDismissedWithValue:(NSArray *)valueSelected{
    switch (selectedButton) {
        case StudentSelected:
        {
            self.selectedStudents = valueSelected;
        }
            break;
        case TeacherSelected:
        {
            self.selectedTeachers = valueSelected;
        }
            break;
        case SubjectSelected:
        {
            self.selectedSubjects = valueSelected;
        }
            break;
        case StandardSelected:
        {
            [self.showStandardDataSelected setTitle:[valueSelected objectAtIndex:0] forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}

- (void)validateFields{
    
}


@end
