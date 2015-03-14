//
//  ShowStudentTableViewController.h
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavProtocol.h"

@interface ShowStudentTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property id <modalControllerDelegate> modalNavigationDelegate;
@property (strong, nonatomic) NSArray *allStudents;
@property (strong, nonatomic) NSMutableArray *selectedStudents;
@property (weak, nonatomic) IBOutlet UITableView *studentTableView;

@end
