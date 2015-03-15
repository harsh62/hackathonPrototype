//
//  SideViewController.m
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import "SideViewController.h"


@interface SideViewController ()

@end

@implementation SideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.userName.text = [[iTeachSingleton sharedManager] userName];
}

- (void)viewGoingToAppear{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
         [self.sideNavigationDelegate homeButtonClicked];
    }
    else if (indexPath.row == 1){
        [self.sideNavigationDelegate profileButtonClicked];
    }
    else if (indexPath.row == 2){
        [self.sideNavigationDelegate connectButtonClicked];
    }
    else if (indexPath.row == 3){
        [self.sideNavigationDelegate sideNavProfileSelected];
    }
    else if (indexPath.row == 4){
        [self.sideNavigationDelegate calendarButtonClicked];
    }
    else if (indexPath.row == 6){
        [self.sideNavigationDelegate signOutButtonClicked];
    }
    else if (indexPath.row == 5){
        [self.sideNavigationDelegate toDoClicked];
    }
    
}

@end
