//
//  ShowTeacherTableViewController.h
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavProtocol.h"

@interface ShowTeacherTableViewController :  UIViewController<UITableViewDataSource, UITableViewDelegate>
@property id <modalControllerDelegate> modalNavigationDelegate;
@property (strong, nonatomic) NSArray *allTeachers;
@property (strong, nonatomic) NSMutableArray *selectedTeachers;
@property (weak, nonatomic) IBOutlet UITableView *teachersTableView;
@end
