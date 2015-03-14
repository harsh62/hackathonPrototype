//
//  WeekViewController.h
//  StrikR
//
//  Created by Rémi Blanc on 23/07/13.
//  Copyright (c) 2013 Mickael Alléon. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface WeekViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>{
    
}

@property (weak, nonatomic) IBOutlet UICollectionView *weekMainCollectionView;

@property (retain, nonatomic)  NSString *nbMatchString;
@property (retain, nonatomic)  NSString *dateWeekString;
@property (retain, nonatomic)  NSString *matchsTextString;

@property (weak, nonatomic) IBOutlet UIButton *strikrButton;
@property int weekNumber;
@property int year;
@property (retain, nonatomic) NSString *backgroundColorCurrentWeek;
@property (retain, nonatomic) NSString *foregroundColorCurrentWeek;

@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet UIView *mainView;


@property (nonatomic, strong) NSMutableArray *weekElements;
@property (nonatomic) int appearPage;


- (IBAction)revealMenu:(id)sender;
- (IBAction)carlsbergMenu:(id)sender;

@end
