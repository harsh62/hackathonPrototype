//
//  SideViewController.h
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavProtocol.h"

@interface SideViewController : UITableViewController
@property id <sideNavigationProtocol> sideNavigationDelegate;
- (void)viewGoingToAppear;
@end
