//
//  ContainerViewController.h
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "SideViewController.h"
#import "NavProtocol.h"
#import "HomeTabViewController.h"


@interface ContainerViewController : UIViewController< sideNavigationProtocol>

@property (strong, nonatomic) HomeTabViewController *mainHomeTabViewController;
@property (strong, nonatomic) SideViewController *sideViewController;
@property (strong, nonatomic) UIButton *sideNavButton;
@end
