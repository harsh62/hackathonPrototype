//
//  WeekViewController.m
//  StrikR
//
//  Created by Rémi Blanc on 23/07/13.
//  Copyright (c) 2013 Mickael Alléon. All rights reserved.
//

#import "WeekViewController.h"
#import "WeekCell.h"
#import "DayCell.h"
#import "DayViewController.h"
#import "Util.h"
#import "MonthViewController.h"
#import "Constantes.h"
#import "CalendarManager.h"



@interface WeekLayout : UICollectionViewLayout
@property (nonatomic) CGSize itemSize;
@property (nonatomic, strong) NSDictionary *layoutInfo;
@end

@implementation WeekLayout

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
	
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setup];
    }
	
    return self;
}

- (void)setup
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
		  self.itemSize = CGSizeMake(160, 114);
    }else{
          self.itemSize = CGSizeMake(256, 240);
    }
  
}

- (void)prepareLayout
{
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath;
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes =
			[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForAlbumPhotoAtIndexPath:indexPath];
            
            [cellLayoutInfo setObject:itemAttributes forKey:indexPath];
        }
    }
    
    self.layoutInfo = cellLayoutInfo;
}


- (CGRect)frameForAlbumPhotoAtIndexPath:(NSIndexPath *)indexPath
{
     if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
         NSInteger row = indexPath.row / 2;
         NSInteger column = indexPath.section * 2 + (indexPath.row%2);
         return CGRectMake(self.itemSize.width * column, self.itemSize.height * row, self.itemSize.width, self.itemSize.height);
     }else{
         NSInteger row = indexPath.row / 3;
         NSInteger column = indexPath.section * 3 + (indexPath.row%3);
         return CGRectMake(self.itemSize.width * column, self.itemSize.height * row, self.itemSize.width, self.itemSize.height);
     }
 }

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
	
	[self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
														 UICollectionViewLayoutAttributes *attributes,
														 BOOL *innerStop) {
		if (CGRectIntersectsRect(rect, attributes.frame)) {
			[allAttributes addObject:attributes];
		}
	}];
	
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[indexPath];
}

- (CGSize)collectionViewContentSize
{
     if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
             return CGSizeMake([self.collectionView numberOfSections] * 2 * self.itemSize.width, 4 * self.itemSize.height);
     }else{
             return CGSizeMake([self.collectionView numberOfSections] * 3 * self.itemSize.width, 4 * self.itemSize.height);
     }

}

@end

@interface WeekViewController ()

@property (nonatomic, strong) NSMutableArray *weeksDictionaries;

@end

@implementation WeekViewController

@synthesize backgroundColorCurrentWeek, foregroundColorCurrentWeek, year, nextButton, weekMainCollectionView, strikrButton;


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue %@" , segue.identifier);
    
	if ([segue.identifier isEqualToString:@"dayView"]){
  
        DayCell *currentCell = (DayCell *) sender;
		DayViewController *dayView = segue.destinationViewController;
        dayView.dayLabel =  currentCell.dayLabel;
        dayView.dayIntLabel = currentCell.dayIntLabel;
        dayView.nbMatchLabel = currentCell.nbMatchLabel;
        dayView.date = currentCell.date;
        dayView.matchTextLabel = currentCell.matchsTextLabel;
        dayView.isChecked = [currentCell.checkedImage isHidden ];
        dayView.isFavorite = [currentCell.favTeamImage isHidden ];
        dayView.dateString = currentCell.dateWeekString;
    }
        
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectItemAtIndexPath %d ", indexPath.row );
    
    if( indexPath.row == 0 ){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (isIPhone){
        
        return 8;
    }else{
        return 8;
    }
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
	NSInteger nRes = 1;
	if (self.weekElements != nil) {
		nRes = [self.weekElements count];
	}
    return nRes;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    [self hideMenuIfNoHidden];
   
    
    NSLog(@"cellForItemAtIndexPath %d " , indexPath.row);
    NSString *dayName = [NSString stringWithFormat:@"day-%d", indexPath.row ];
    
	WeekInfo *weekInfo = [self.weekElements objectAtIndex:indexPath.section];
	
    if( indexPath.row == 0 ){
      
        WeekCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"weekCell" forIndexPath:indexPath];
        
        [cell.dateWeekLabel setText:weekInfo.dateWeekString];
        [cell.nbMatchsLabel setText:[NSString stringWithFormat:@"%d",weekInfo.nbMatch]];
        [cell.matchsTextLabel setText:(weekInfo.nbMatch==1)?NSLocalizedString(@"Match", @"Match"):NSLocalizedString(@"Matchs", @"Matchs")];
       
        [cell.nbMatchsLabel setTextColor:[UIColor whiteColor] ];
        
		[cell.checkedImage setHidden:!weekInfo.isCheckIn];
		[cell.favoriteImage setHidden:!weekInfo.isFavoriteTeam];
        
        cell.layer.borderWidth=0.8f;
        cell.layer.borderColor=[Util colorFromHexString:@"e5e5e5"].CGColor;
        
        if( isIPad){
            cell.layer.borderWidth=2.0f;
        }
        
        return cell;
    }else{
        NSString *cellName = @"dayCell";
        
        DayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
		
		NSDateFormatter *formatterDay = [[NSDateFormatter alloc] init];[formatterDay setDateFormat:@"d"];
		NSDateFormatter *formatterMonth = [[NSDateFormatter alloc] init];[formatterMonth setDateFormat:@"MM"];
		NSDateFormatter *dateJsonFormatter = [[NSDateFormatter alloc] init];[dateJsonFormatter setDateFormat:@"yyyy-MM-dd"];
		
		NSDate *now = [NSDate date];
		NSString *jsonFormatToday = [dateJsonFormatter stringFromDate:now];
		NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		
		NSDateComponents *comp = [[NSDateComponents alloc] init];
		[comp setWeek:weekInfo.weekNumber];
		[comp setYear:weekInfo.year];
		[comp setWeekday:indexPath.row];
		
        NSDate *resultDate = [gregorian dateFromComponents:comp];
        NSString *myDateString = [WeekViewController getDayName: [formatterDay stringFromDate:resultDate] month: [formatterMonth stringFromDate:resultDate] ];
        NSString *date = [ dateJsonFormatter stringFromDate:resultDate ];
        
        NSArray *matchsAtDate =[[NSArray alloc] init];
        
        int nbMatch = [ matchsAtDate count];
        
        bool existFavoriteTeam = false;
        bool existCheckInMatch = false;
        
//        for(id match in matchsAtDate ){
//            if( [MyFavoriteTeamsViewController isFavorite:[match objectForKey:@"team_ext"] ] ||
//               [MyFavoriteTeamsViewController isFavorite:[match objectForKey:@"team_home"] ] ){
//                existFavoriteTeam = true;
//            }
//            if( [MyCheckInsViewController isChecked:[match objectForKey:@"id"] ] ){
//                existCheckInMatch = true;
//            }
//        }
     
        cell.date = date;
        [cell.dayLabel setText: NSLocalizedString( dayName, dayName)];
        [cell.dayIntLabel setText:myDateString ];
    
        if( nbMatch == 0 ) {
            [cell.matchsTextLabel setHidden:YES ];
            [cell.nbMatchLabel setText:@"" ];
            [cell.ballImage setHidden:YES ];
            [cell.favTeamImage setHidden:YES];
            [cell.checkedImage setHidden:YES];
            cell.userInteractionEnabled = NO;
        }else{
            [cell.matchsTextLabel setHidden:NO ];
            [cell.nbMatchLabel setText:[NSString stringWithFormat:@"%d",nbMatch]];
            [cell.ballImage setHidden:NO ];
            cell.userInteractionEnabled = YES;
            
            if( nbMatch == 1 ){
                [cell.matchsTextLabel setText: NSLocalizedString( @"Match", @"Match" ) ];
            }else{
                [cell.matchsTextLabel setText: NSLocalizedString( @"Matchs", @"Matchs" ) ];
            }
   
			[cell.favTeamImage setHidden:!existFavoriteTeam ];
			[cell.checkedImage setHidden:!existCheckInMatch];
        }
        
        if([date isEqualToString: jsonFormatToday ]){
            cell.layer.borderWidth=1.0f;
            if( isIPad){
                cell.layer.borderWidth=2.0f;
            }
            
            cell.layer.borderColor=[Util colorFromHexString:@"049C3B"].CGColor;
        }else{
            cell.layer.borderWidth=0.8f;
            if( isIPad){
                cell.layer.borderWidth=2.0f;
            }
            
            cell.layer.borderColor=[Util colorFromHexString:@"e5e5e5"].CGColor;
        }
		
		cell.dateWeekString = weekInfo.dateWeekString;
      
        NSLog(@"COunt for index path:%d (%d)",indexPath.row ,   [cell.gestureRecognizers count]);
        return cell;
    }
    
    
    
}

- (void)collectionView:(UICollectionView *)colView
didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // cell.contentView.backgroundColor = [UIColor blueColor];
    if( indexPath.row > 0 ){
        DayCell* cell =( DayCell*) [colView cellForItemAtIndexPath:indexPath];
        [cell.contentView setBackgroundColor:[Util colorFromHexString:COLOR_Grey_dataviz]];
    }
    
}
- (void)collectionView:(UICollectionView *)colView
didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    if( indexPath.row > 0 ){
        DayCell* cell =( DayCell*) [colView cellForItemAtIndexPath:indexPath];
        [cell.contentView setBackgroundColor:nil];
    }
    
}

bool isIPad;
bool isIPhone;
bool isPortrait;
bool isLandscape;


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    isIPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    isIPhone = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
    isPortrait = UIDeviceOrientationIsPortrait(self.interfaceOrientation);
    isLandscape =  UIDeviceOrientationIsLandscape(self.interfaceOrientation);
    
	[self.weekMainCollectionView setDirectionalLockEnabled:YES];
	
    CalendarManager *sharedManager = [CalendarManager sharedManager];
    sharedManager.matchOfTheWeek = [[NSMutableArray alloc] init];
}


+(NSString *)getDayName:(NSString *)day month:(NSString *)month{
    
    NSString *startMonthShortName = [NSString stringWithFormat:@"monthShort-%@", month ];
    NSString *dayName = [NSString stringWithFormat:@"%@ %@", day, NSLocalizedString( startMonthShortName, startMonthShortName) ];
    return dayName;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//MODULE PARTAGE

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self hideMenuIfNoHidden];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self initShareAndCarlsbergMenu];
	[self.weekMainCollectionView setContentOffset:CGPointMake(self.appearPage*self.weekMainCollectionView.bounds.size.width,0.0)];

    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
	

}


-(void)hideMenuIfNoHidden {
//    if( ![socialAndSharingMenuViewController.view isHidden ] ){
//        [Util hideMenu:socialAndSharingMenuViewController.view withX:[Util getXStartMenu: self ]  withY:0];
//        [strikrButton setImage:[UIImage imageNamed:@"logo_strikr_off.png"] forState:UIControlStateNormal ];
//    }
}
//
-(void)initShareAndCarlsbergMenu{
//    if( socialAndSharingMenuViewController == nil ){
//        socialAndSharingMenuViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"socialAndShareMenu"];
//    }
//    
//    if( ![socialAndSharingMenuViewController isViewLoaded] || !socialAndSharingMenuViewController.view.window ){
//        [self.mainView addSubview:socialAndSharingMenuViewController.view];
//        [socialAndSharingMenuViewController.view setFrame:CGRectMake([Util getXStartMenu: self ] , -SOCIAL_MENU_SIZE, 320 ,SOCIAL_MENU_SIZE)];
//        [socialAndSharingMenuViewController.view setHidden:YES ];
//    }
//    
}
//
//- (IBAction)carlsbergMenu:(id)sender{
//    if( [socialAndSharingMenuViewController.view isHidden] ){
//        [self.view addGestureRecognizer:self.slidingViewController.panGesture];
//        self.slidingViewController.panGesture.delegate = self;
//
//        [Util showMenu:socialAndSharingMenuViewController.view withX:[Util getXStartMenu: self ]  withY:0];
//        [strikrButton setImage:[UIImage imageNamed:@"logo_strikr_on.png"] forState:UIControlStateNormal ];
//    }else{
//        [Util hideMenu:socialAndSharingMenuViewController.view withX:[Util getXStartMenu: self ]  withY:0];
//        [strikrButton setImage:[UIImage imageNamed:@"logo_strikr_off.png"] forState:UIControlStateNormal ];
//    }
//}
//
//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    
//    if( [touch.view isKindOfClass:[UIButton class ]]){
//        if( [touch.view tag] != 222 ){
//            [self hideMenuIfNoHidden];
//            if( self.slidingViewController.topViewController.view.frame.origin.x == 0 ){
//                [self.view removeGestureRecognizer:self.slidingViewController.panGesture];
//            }else{
//                [self.slidingViewController resetTopView];
//            }
//        }
//    }else{
//        [self hideMenuIfNoHidden];
//        if( self.slidingViewController.topViewController.view.frame.origin.x == 0 ){
//            [self.view removeGestureRecognizer:self.slidingViewController.panGesture];
//        }else{
//            [self.slidingViewController resetTopView];
//        }
//        
//    }
//    return YES;
//}
//
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touch began ") ;
//    if( self.slidingViewController.topViewController.view.frame.origin.x == 0 ){
//        [self.view removeGestureRecognizer:self.slidingViewController.panGesture];
//    }
//}
//
//- (IBAction)revealMenu:(id)sender{
//    [self hideMenuIfNoHidden];
//    if( self.slidingViewController.topViewController.view.frame.origin.x == 0 ){
//        [self.view addGestureRecognizer:self.slidingViewController.panGesture];
//        self.slidingViewController.panGesture.delegate = self;
//        [self.slidingViewController anchorTopViewTo:ECRight];
//    }else{
//        [self.slidingViewController resetTopView];
//    }
//}
//
//
//
////Gestion rotation
//
//-(void) changeStory{
//    UIStoryboard* story = nil;
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        
//        NSString * storyboardName = [self.storyboard valueForKey:@"name"];
//        NSString * storyName = @"";
//        if (UIDeviceOrientationIsPortrait(self.interfaceOrientation)){
//            NSLog(@"** change to -> portrait  " );
//            storyName = @"iPad-portrait";
//            if( ![storyboardName isEqualToString:storyName] ){
//                [[NSUserDefaults standardUserDefaults] setObject:@"monthView" forKey:@"rotateTo" ];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//                story = [UIStoryboard storyboardWithName:storyName bundle:nil];
//                
//                InitialSlidingViewController *initialScene = (InitialSlidingViewController*)[story instantiateViewControllerWithIdentifier:@"init"];
//                self.view.window.rootViewController = initialScene;
//            }
//        }else{
//            NSLog(@"** change to -> paysage  " );
//            storyName = @"iPad-paysage";
//            
//            if( ![storyboardName isEqualToString:storyName] ){
//                [[NSUserDefaults standardUserDefaults] setObject:@"monthView" forKey:@"rotateTo" ];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//                story = [UIStoryboard storyboardWithName:storyName bundle:nil];
//                
//                InitialIpadViewController *initialScene = (InitialIpadViewController*)[ story instantiateViewControllerWithIdentifier:@"init"];
//                self.view.window.rootViewController = initialScene;
//                [initialScene setSelectedButton:initialScene.calendarButton];
//            }
//        }
//    }
//}
//
//-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
//    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
//    NSLog(@"month willRotateToInterfaceOrientation %d ",self.interfaceOrientation );
//}
//
//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation duration:(NSTimeInterval)duration {
//    [super willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
//    NSLog(@"month willAnimateRotationToInterfaceOrientation %d ",self.interfaceOrientation );
//    [self changeStory];
//}
//
//- (void) orientationChanged:(NSNotification *)note
//{
//    NSLog(@"month orientationChanged %d ",self.interfaceOrientation );
//    
//    NSString *reqSysVer = @"7.0";
//    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
//    if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending){
//        [self performSelector:@selector(changeStory) withObject:nil afterDelay:0.5];
//    }else{
//        [self changeStory];
//    }
//}
@end
