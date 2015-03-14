//
//  ShowSubjectsTableViewController.h
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavProtocol.h"

@interface ShowSubjectsTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property id <modalControllerDelegate> modalNavigationDelegate;
@property (strong, nonatomic) NSArray *allSubjects;
@property (strong, nonatomic) NSMutableArray *selectedSubjects;
@property (weak, nonatomic) IBOutlet UITableView *subjectsTableView;

@end
