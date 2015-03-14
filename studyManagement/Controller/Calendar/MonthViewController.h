//
//  MonthViewController.h
//  StrikR
//
//  Created by Rémi Blanc on 24/07/13.
//  Copyright (c) 2013 Mickael Alléon. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WeekInfo : NSObject
@property (nonatomic) int weekNumber;
@property (nonatomic) int year;
@property (nonatomic) BOOL isCurrent;
@property (nonatomic, strong) NSString *foregroundColorCurrentWeek;
@property (nonatomic) int nbMatch;
@property (nonatomic, strong) NSString *dateWeekString;
@property (nonatomic) BOOL isFavoriteTeam;
@property (nonatomic) BOOL isCheckIn;
@end

@interface MonthInfo : NSObject
@property (nonatomic, strong) NSString *month;
@property (nonatomic) int year;
@end

@interface MonthViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>{
    UIView *refreshHeaderView;
    UILabel *refreshLabel;
    UILabel *dateLabel;
    UIImageView *refreshArrow;
    UIActivityIndicatorView *refreshSpinner;
    BOOL isDragging;
    BOOL isLoading;
    NSString *textPull;
    NSString *textRelease;
    NSString *textLoading;
    NSString *textDate;
    
}
@property (nonatomic, retain) UIView *refreshHeaderView;
@property (nonatomic, retain) UILabel *refreshLabel;
@property (nonatomic, retain) UIImageView *refreshArrow;
@property (nonatomic, retain) UIActivityIndicatorView *refreshSpinner;
@property (nonatomic, copy) NSString *textPull;
@property (nonatomic, copy) NSString *textRelease;
@property (nonatomic, copy) NSString *textLoading;
@property (weak, nonatomic) IBOutlet UIImageView *ballIpadImageView;

@property (weak, nonatomic) IBOutlet UILabel *nbMatchForThisWeekLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *allMonthCollectionView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic ) NSDictionary *calendarArray;
@property (strong, nonatomic ) NSMutableArray *dayOfCurrentWeek;

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIButton *strikrButton;

//@property (nonatomic, retain) SocialAndSharingMenuViewController *socialAndSharingMenuViewController;
@property (strong, nonatomic ) NSMutableArray *startEndWeek;

@property (nonatomic,strong) IBOutlet UILabel *weekMatch;


// IPAD Add
@property (nonatomic,strong) IBOutlet UITableView *matchWeek;


- (IBAction)revealMenu:(id)sender;
- (IBAction)carlsbergMenu:(id)sender;

+ (NSMutableArray *) getMatchOfCurrentWeek:(NSString *)startDay startMonth:(NSString *)startMonth endDay:(NSString *)endDay endMonth:(NSString *)endMonth year:(int) year ;


+(NSString *)getWeekName:(NSString *)startDay startMonth:(NSString *)startMonth endDay:(NSString *)endDay endMonth:(NSString *)endMonth;
@end
