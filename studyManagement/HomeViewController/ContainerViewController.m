//
//  ContainerViewController.m
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import "ContainerViewController.h"


@interface ContainerViewController ()

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setHidden:YES];
    [self addMainHomeView];
    [self createSideNavButton];
    [self addSwipeGestures];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)addSwipeGestures{
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewToNormalPosition)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.mainHomeTabViewController.view addGestureRecognizer:leftSwipe];
    
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewToSidePosition)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.sideNavButton addGestureRecognizer:rightSwipe];
    
}

- (void)createSideNavButton{
    self.sideNavButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.sideNavButton setFrame:CGRectMake(-5, 411, 20, 69)];
    [self.sideNavButton setTintColor:[UIColor blackColor]];
    [self.sideNavButton setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    //[self.sideNavButton setTitle:@"Side" forState:UIControlStateNormal];
    [self.sideNavButton addTarget:self action:@selector(sideNavigationClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.sideNavButton setTag:100];
    [self.view addSubview:self.sideNavButton];
}

- (SideViewController *) getSideView{
    if(!self.sideViewController){
        UIStoryboard *currentStoryBoard = self.storyboard;
        self.sideViewController = [currentStoryBoard instantiateViewControllerWithIdentifier:@"sideViewController"];
        CGRect rect = [[UIScreen mainScreen] bounds];
        
        
        self.sideViewController.sideNavigationDelegate = self;
        [self.sideViewController.view setFrame:CGRectMake(-200, 0, 200, rect.size.height)];
        [self.view addSubview:self.sideViewController.view];
        [self addChildViewController:self.sideViewController];
    }
    return  self.sideViewController;
}


- (void)addMainHomeView{
    self.mainHomeTabViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainHomeViewTabController"];
    
    [self.mainHomeTabViewController.view setFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:self.mainHomeTabViewController.view];
    [self addChildViewController:self.mainHomeTabViewController];
    [self.view sendSubviewToBack:self.mainHomeTabViewController.view];
}

- (IBAction)sideNavigationClicked:(id)sender {
    UIButton *weak_self = (UIButton *)sender;
    
    if(weak_self.tag == 100)
    {

        
        [self moveViewToSidePosition];
    }
    else{

        [self moveViewToNormalPosition];
        
        
    }
}

- (void) moveViewToSidePosition{
    
    SideViewController *rightViewController = [self getSideView];
    [rightViewController.view setHidden:NO];
    [rightViewController viewGoingToAppear];
    
    [self.mainHomeTabViewController.view setUserInteractionEnabled:NO];
    [UIView animateWithDuration:0.4
                          delay:0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^ {
                         [rightViewController.view setFrame:CGRectMake(0, 0, 200, [[UIScreen mainScreen] bounds].size.height) ];
                         [self.sideNavButton setFrame:CGRectMake(195, self.sideNavButton.frame.origin.y, self.sideNavButton.frame.size.width, self.sideNavButton.frame.size.height)];
                     }completion:^(BOOL finished) {
                         self.sideNavButton.tag = 101;
                     }];
}
- (void)moveViewToNormalPosition{
    SideViewController *rightViewController = [self getSideView];
    [self.mainHomeTabViewController.view setUserInteractionEnabled:YES];
    
    [UIView animateWithDuration:0.4
                          delay:0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^ {
                         [rightViewController.view setFrame:CGRectMake(-200, 0, 200, [[UIScreen mainScreen] bounds].size.height) ];
                         [self.sideNavButton setFrame:CGRectMake(-5, self.sideNavButton.frame.origin.y, self.sideNavButton.frame.size.width, self.sideNavButton.frame.size.height)];
                     }completion:^(BOOL finished) {
                         self.sideNavButton.tag = 100;
                         [rightViewController.view setHidden:YES];
                     }];
}


#pragma mark SideNavigation
- (void)sideNavProfileSelected{
    [self moveViewToNormalPosition];
    [self.mainHomeTabViewController setSelectedIndex:1];
}

@end
