//
//  MonthViewController.m
//  StrikR
//
//  Created by Rémi Blanc on 24/07/13.
//  Copyright (c) 2013 Mickael Alléon. All rights reserved.
//

#import "MonthViewController.h"
#import "WeekViewController.h"
#import "WeekCell.h"
#import "MonthCell.h"
#import "Util.h"
#import "Constantes.h"
#import "CalendarManager.h"


#define kBgQueue dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@implementation WeekInfo
@end
@implementation MonthInfo
@end

@interface MonthViewController ()

@property (nonatomic, strong) NSMutableArray *collectionElements;
@property (nonatomic, strong) NSMutableArray *weeksElements;

@end

@implementation MonthViewController

@synthesize calendarArray, allMonthCollectionView, strikrButton, nbMatchForThisWeekLabel, ballIpadImageView,textRelease,textPull,textLoading,refreshArrow,refreshHeaderView,refreshSpinner,refreshLabel;
@synthesize dayOfCurrentWeek;
@synthesize startEndWeek;
@synthesize weekMatch;


// Add Ipad
@synthesize matchWeek;

NSArray *nbOfDayMonthbyMonth;

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    NSLog(@"prepareForSegue %@" , segue.identifier);
// 
//        if ([segue.identifier isEqualToString:@"weekView"]){
//			
//            WeekViewController *weekView = segue.destinationViewController;
//			weekView.weekElements = self.weeksElements;
//			
//			WeekCell *currentCell = (WeekCell *) sender;
//			int page = 0;
//			if (currentCell.weekInfo != nil) {
//				page = [self.weeksElements indexOfObject:currentCell.weekInfo];
//			}
//			weekView.appearPage = page;
//
//    }else if ([segue.identifier isEqualToString:@"feedMatch"]){
//           
//           
//           InitialIpadViewController *ctr = (InitialIpadViewController *) self.view.window.rootViewController;
//           [ctr setSelectedButton:ctr.matchesButton];
//           
//           FeedMatchViewController *feedView = segue.destinationViewController;
//           CheckInMatchCell *currenCell = (CheckInMatchCell *) sender;
//
//          NSArray  *listMatchs = [[InitialSlidingViewController getLiveMatchsJSON] objectForKey:@"list"];
//           for( id match in listMatchs ){
//               NSString *currentMatchId = [match objectForKey:@"id_match"];
//               if( [currentMatchId isEqualToString: currenCell.matchId] ){
//                   feedView.match = match;
//                   
//               }
//           }
//           
//           feedView.homeTeam = currenCell.homeTeam;
//           feedView.extTeam =  currenCell.extTeam;
//
//        
//        
//        }
// 
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectItemAtIndexPath %ld ", (long)indexPath.row );
    
//    if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)){
		if ([[self.collectionElements objectAtIndex:indexPath.row] isKindOfClass:[WeekInfo class]]) {
			WeekInfo *weekInfo = (WeekInfo *)[self.collectionElements objectAtIndex:indexPath.row];
			
			NSString *periodesString = weekInfo.dateWeekString;
			NSLog(@"weekName : %@", periodesString);
			
			NSArray* dateStrings = [periodesString componentsSeparatedByString:@"-"];
			NSLog(@" dateString : %@", [dateStrings objectAtIndex:0]);
			NSDateFormatter *numMonthFormater;
            
			
            NSRange point = [periodesString rangeOfString:@"."];
            
            if(point.location == NSNotFound){
                numMonthFormater = [[NSDateFormatter alloc] init];[numMonthFormater setDateFormat:@"dd MMM"];
                
                
            }else{
                
                 numMonthFormater = [[NSDateFormatter alloc] init];[numMonthFormater setDateFormat:@"dd MMM."];
            }

            
			
			[numMonthFormater  setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
			
			NSCalendar* cal = [NSCalendar currentCalendar];
			NSUInteger comps = NSCalendarUnitDay | NSCalendarUnitMonth;
			
			
			NSDate* date1 = [numMonthFormater dateFromString: dateStrings[0] ];
			NSDateComponents* comps1 = [cal components:comps fromDate:date1];
			NSLog(@"%ld %ld", (long)comps1.day, (long)comps1.month);
			
			NSDate* date2 = [numMonthFormater dateFromString: dateStrings[1] ];
			NSDateComponents* comps2 = [cal components:comps fromDate:date2];
			NSLog(@"%ld %ld", (long)comps2.day, (long)comps2.month);
			
			CalendarManager *sharedManager = [CalendarManager sharedManager];
			
			NSString *startDay = [[NSString alloc] initWithFormat:@"%ld", (long)comps1.day];
			NSString *startMonth = [[NSString alloc] initWithFormat:@"%ld",(long)comps1.month];
			
			NSString *endDay = [[NSString alloc] initWithFormat:@"%ld", (long)comps2.day];
			NSString *endMonth = [[NSString alloc] initWithFormat:@"%ld",(long)comps2.month];
            
			sharedManager.matchOfTheWeek = [MonthViewController getMatchOfCurrentWeek:startDay startMonth:startMonth endDay:endDay endMonth:endMonth year:weekInfo.year];
            
			
            
            int nbMatchs =  [sharedManager.matchOfTheWeek count];
            if( nbMatchs == 0 ){
                [nbMatchForThisWeekLabel setHidden:YES];
                [ballIpadImageView setHidden:YES];
            }else{
                [ballIpadImageView setHidden:NO];
                 [nbMatchForThisWeekLabel setHidden:NO];
                NSString *matches = (nbMatchs==1)?NSLocalizedString(@"Match", @"Match"):NSLocalizedString(@"Matchs", @"Matchs");
                [nbMatchForThisWeekLabel setText:[NSString stringWithFormat:@"%d %@", nbMatchs, matches ]];
            }
    
			[self.matchWeek reloadData];
			weekMatch.text = periodesString;
			//found it...
		}
		
//    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //43 semaines + 10 mois
    return [self.collectionElements count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    [self hideMenuIfNoHidden];
    
    
    if( [[self.collectionElements objectAtIndex:indexPath.row] isKindOfClass:[MonthInfo class]] ){
        MonthCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"monthCell" forIndexPath:indexPath];
		
		MonthInfo *monthInfo = (MonthInfo *)[self.collectionElements objectAtIndex:indexPath.row];
		if (monthInfo.month != nil) {
			[cell.monthLabel setText:NSLocalizedString(monthInfo.month, monthInfo.month)];
			[cell.yearLabel setText:[NSString stringWithFormat:@"%d",monthInfo.year]];
		}
		else {
			[cell.monthLabel setText:@""];
			[cell.yearLabel setText:@""];
		}
        cell.layer.borderWidth=0.8f;
         if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)){
              cell.layer.borderWidth=2.0f;
         }
        cell.layer.borderColor=[Util colorFromHexString:@"e5e5e5"].CGColor;
        
        return cell;
    }
	else{
        WeekCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"weekCell" forIndexPath:indexPath];
		
		WeekInfo *weekInfo = (WeekInfo *)[self.collectionElements objectAtIndex:indexPath.row];
		cell.weekInfo = weekInfo;
		
        [cell.dateWeekLabel setText:weekInfo.dateWeekString];
        
        if(weekInfo.isCurrent){
            
            if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)){
				
                NSString *periodesString = cell.dateWeekLabel.text;
				
                NSArray* dateStrings = [periodesString componentsSeparatedByString:@"-"];
                NSLog(@" dateString : %@", [dateStrings objectAtIndex:0]);
				
                NSDateFormatter *numMonthFormater = [[NSDateFormatter alloc] init];[numMonthFormater setDateFormat:@"dd MMM."];
                [numMonthFormater  setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
				
                NSCalendar* cal = [NSCalendar currentCalendar];
                NSUInteger comps = NSCalendarUnitDay | NSCalendarUnitMonth;
				
                NSDate* date1 = [numMonthFormater dateFromString: dateStrings[0] ];
                NSDateComponents* comps1 = [cal components:comps fromDate:date1];
				NSLog(@"%ld %ld", (long)comps1.day, (long)comps1.month);
                
                NSDate* date2 = [numMonthFormater dateFromString: dateStrings[1] ];
                NSDateComponents* comps2 = [cal components:comps fromDate:date2];
                NSLog(@"%ld %ld", (long)comps2.day, (long)comps2.month);
                
                CalendarManager *sharedManager = [CalendarManager sharedManager];
                
                NSString *startDay = [[NSString alloc] initWithFormat:@"%ld", (long)comps1.day];
                NSString *startMonth = [[NSString alloc] initWithFormat:@"%ld",(long)comps1.month];
                
                NSString *endDay = [[NSString alloc] initWithFormat:@"%ld", (long)comps2.day];
                NSString *endMonth = [[NSString alloc] initWithFormat:@"%ld",(long)comps2.month];
                
				sharedManager.matchOfTheWeek = [MonthViewController getMatchOfCurrentWeek:startDay startMonth:startMonth endDay:endDay endMonth:endMonth year:weekInfo.year];
                
                
                int nbMatchs =  [sharedManager.matchOfTheWeek count];
                if( nbMatchs == 0 ){
                    [nbMatchForThisWeekLabel setHidden:YES];
                    [ballIpadImageView setHidden:YES];
                }else{
                    [ballIpadImageView setHidden:NO];
                    [nbMatchForThisWeekLabel setHidden:NO];
                    NSString *matches = (nbMatchs==1)?NSLocalizedString(@"Match", @"Match"):NSLocalizedString(@"Matchs", @"Matchs");
                    [nbMatchForThisWeekLabel setText:[NSString stringWithFormat:@"%d %@", nbMatchs, matches ]];
                }
                
                [self.matchWeek reloadData];
                weekMatch.text = cell.dateWeekLabel.text;
            }
			
            [cell.checkedImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@checkin_white", prefixImage]] ];
            [cell.favoriteImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@favorite_white", prefixImage]] ];
            [cell.ballImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@ball_white", prefixImage]] ];
            [cell.colorView setBackgroundColor:[Util colorFromHexString:COLOR_CURRENT_DAY] ];
			
        }
		else {

            [cell.checkedImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@checkin_green", prefixImage]] ];
            [cell.favoriteImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@favorite_green", prefixImage]] ];
            [cell.ballImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@ball_black", prefixImage]] ];
            [cell.colorView setBackgroundColor:[UIColor whiteColor] ];

        }
        
        if( weekInfo.nbMatch > 0 ){
            [cell.favoriteImage setHidden:NO];
            [cell.ballImage setHidden:NO];
            
			[cell.nbMatchsLabel setText:[NSString stringWithFormat:@"%d",weekInfo.nbMatch]];
			[cell.matchsTextLabel setText:(weekInfo.nbMatch==1)?NSLocalizedString(@"Match", @"Match"):NSLocalizedString(@"Matchs", @"Matchs")];
			
			[cell.favoriteImage setHidden:!weekInfo.isFavoriteTeam ];
			[cell.checkedImage setHidden:!weekInfo.isCheckIn];
            
        }else{
            [cell.nbMatchsLabel setText:@""];
            [cell.matchsTextLabel setText:@""];
            [cell.favoriteImage setHidden:YES];
            [cell.ballImage setHidden:YES];
        }
		
        if( weekInfo.foregroundColorCurrentWeek ){
            [cell.dateWeekLabel setTextColor:[Util colorFromHexString: weekInfo.foregroundColorCurrentWeek]];
            [cell.nbMatchsLabel setTextColor:[Util colorFromHexString: weekInfo.foregroundColorCurrentWeek]];
            [cell.matchsTextLabel setTextColor:[Util colorFromHexString: weekInfo.foregroundColorCurrentWeek]];
            [cell.nbMatchsLabel setHighlightedTextColor:[Util colorFromHexString: weekInfo.foregroundColorCurrentWeek]];
            [cell.matchsTextLabel setHighlightedTextColor:[Util colorFromHexString: weekInfo.foregroundColorCurrentWeek]];
            [cell.dateWeekLabel setHighlightedTextColor:[Util colorFromHexString: weekInfo.foregroundColorCurrentWeek]];
        }
		
        cell.weekNumber = [NSString stringWithFormat:@"%d",weekInfo.weekNumber];
        cell.year = weekInfo.year;
        
        //test if current week
		
        cell.layer.borderWidth=0.8f;
        
        if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)){
            cell.layer.borderWidth=2.0f;
        }
        cell.layer.borderColor=[Util colorFromHexString:@"e5e5e5"].CGColor;
		
		
		return cell;
		
        
    }
    
}

- (void)collectionView:(UICollectionView *)colView
didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
   
   // cell.contentView.backgroundColor = [UIColor blueColor];
    if( [[self.collectionElements objectAtIndex:indexPath.row] isKindOfClass:[MonthInfo class]] ){
         
    }else{
        
        WeekCell* cell =( WeekCell*) [colView cellForItemAtIndexPath:indexPath];
        WeekInfo *weekInfo = (WeekInfo *)[self.collectionElements objectAtIndex:indexPath.row];
		cell.weekInfo = weekInfo;
		
        [cell.dateWeekLabel setText:weekInfo.dateWeekString];
        
        if(!weekInfo.isCurrent){
            [cell.colorView setBackgroundColor:[Util colorFromHexString:COLOR_Grey_dataviz]];
        }
    }
   
}
- (void)collectionView:(UICollectionView *)colView
didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    if( [[self.collectionElements objectAtIndex:indexPath.row] isKindOfClass:[MonthInfo class]] ){
      
    }else{
        WeekCell* cell =( WeekCell*) [colView cellForItemAtIndexPath:indexPath];
        WeekInfo *weekInfo = (WeekInfo *)[self.collectionElements objectAtIndex:indexPath.row];
		cell.weekInfo = weekInfo;
		
        [cell.dateWeekLabel setText:weekInfo.dateWeekString];
        
        if(!weekInfo.isCurrent){

        [cell.colorView setBackgroundColor:[UIColor whiteColor]];
        }
    }
 
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
		return CGSizeMake(160, 114);
    }else{
        if (UIDeviceOrientationIsPortrait(self.interfaceOrientation)){
           return CGSizeMake(256 , 240);
        }else {
            return CGSizeMake(211 , 234);
        }
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

bool isInitialized = false;
int indexToScroll = 0;

-(NSMutableArray *)initialisationCalendar{
    calendarArray = [[NSDictionary alloc] init];
    NSMutableArray *startEndDateOfWeek = [[NSMutableArray alloc] init];
    
    int nbWeekOfPremierLeague = 42;
    int currentWeekInt = 33;
    int currentYearInt = 2013;
    
    self.dayOfCurrentWeek = [NSMutableArray array];
	
	self.collectionElements = [NSMutableArray array];
	self.weeksElements = [NSMutableArray array];
    
    NSDateFormatter *dayFormater = [[NSDateFormatter alloc] init];[dayFormater setDateFormat:@"dd"];
    NSDateFormatter *numMonthFormater = [[NSDateFormatter alloc] init];[numMonthFormater setDateFormat:@"MM"];
    NSDateFormatter *yearFormater = [[NSDateFormatter alloc] init];[yearFormater setDateFormat:@"yyyy"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];[formatter setDateFormat:@"d"];
    NSDateFormatter *dateJsonFormatter = [[NSDateFormatter alloc] init];[dateJsonFormatter setDateFormat:@"yyyy-MM-dd"];
    
    
    NSDate *now = [NSDate date];
    NSString *yearNow = [yearFormater stringFromDate:now];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:1];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    
    NSInteger weekNumber =  [[calendar components: NSWeekCalendarUnit fromDate:now] week];
	
    
	NSString *currentMonth = @"";
    
    for( int i = 0; i < nbWeekOfPremierLeague; i=i+1){
        
        
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        
        [comps setWeekOfYear:currentWeekInt];
        [comps setYear:currentYearInt];
        
        NSString *myStartDateString;
        NSString *myStartMonthNum;
        NSString *myEndDateString = @"";
        NSString *myEndMonthNum = @"";
        
        int nbMatchInThisWeek = 0;
        
        //NSString *currentYearOnLastDay;
        
        
        bool existFavoriteTeam = false;
        bool existCheckInMatch = false;
        
        [comps setWeekday:1];
        int indice = 1;
        
        bool changeYear = false;
        for( int j = 1; j < 8; j=j+1){
			
            [comps setWeekday:indice];
			
            NSDate *currentDayDate = [gregorian dateFromComponents:comps];
			
            NSString *currentDateJson = [dateJsonFormatter stringFromDate:currentDayDate];
            if( j == 1){
                myStartDateString = [formatter stringFromDate:currentDayDate];
                myStartMonthNum = [numMonthFormater stringFromDate:currentDayDate];
            }else{
                myEndDateString = [formatter stringFromDate:currentDayDate];
                myEndMonthNum = [numMonthFormater stringFromDate:currentDayDate];
            }
            nbMatchInThisWeek = nbMatchInThisWeek + [[calendarArray objectForKey:currentDateJson ] count];
			
            
//            NSArray *matchsAtDate =[[[InitialSlidingViewController getCalendarJSON] objectForKey:@"dates"]objectForKey: currentDateJson];
//            for(id match in matchsAtDate ){
//                if( [MyFavoriteTeamsViewController isFavorite:[match objectForKey:@"team_ext"] ] ||
//                   [MyFavoriteTeamsViewController isFavorite:[match objectForKey:@"team_home"] ] ){
//                    existFavoriteTeam = true;
//                }
//                if( [MyCheckInsViewController isChecked:[match objectForKey:@"id"] ] ){
//                    existCheckInMatch = true;
//                }
//            }
            
            if( [[dayFormater stringFromDate: currentDayDate ] isEqualToString:@"31"] &&
               [[numMonthFormater stringFromDate: currentDayDate ] isEqualToString:@"12"] ){
                currentYearInt = [comps year] +1;
                currentWeekInt = 1;
                [comps setWeekOfYear:currentWeekInt];
                [comps setYear: currentYearInt ];
				[comps setDay:1 ];
				[comps setMonth:1 ];
                indice = 1;
                changeYear = true;
            }else{
                indice = indice+1;
                if( changeYear ){
                    [comps setDay:[comps day] +1 ];
                }
            }
            
        }
		
		[startEndDateOfWeek addObject:myStartDateString];
        [startEndDateOfWeek addObject:myStartMonthNum];
        [startEndDateOfWeek addObject:myEndDateString];
        [startEndDateOfWeek addObject:myEndMonthNum];
		
		WeekInfo *weekInfo = [[WeekInfo alloc] init];
		weekInfo.weekNumber = [comps weekOfYear];
		weekInfo.year = [comps year];
		weekInfo.nbMatch = nbMatchInThisWeek;
        
        NSString *weekName =[MonthViewController getWeekName:myStartDateString startMonth:myStartMonthNum endDay:myEndDateString endMonth: myEndMonthNum];
		
		weekInfo.dateWeekString = weekName;
		
        if(![myEndMonthNum isEqualToString:currentMonth] ){
			if(  [self.collectionElements count] % 2 != 0 ){
				MonthInfo *monthInfo = [[MonthInfo alloc] init];
				[self.collectionElements addObject:monthInfo];
            }
			currentMonth = myEndMonthNum;
			MonthInfo *monthInfo = [[MonthInfo alloc] init];
			monthInfo.month = [NSString stringWithFormat:@"month-%@", currentMonth ];
			monthInfo.year = currentYearInt;
			[self.collectionElements addObject:monthInfo];
        }
        
        if( weekNumber == weekInfo.weekNumber && [comps year] == [yearNow intValue]){
            
			weekInfo.isCurrent = YES;
			weekInfo.foregroundColorCurrentWeek = @"ffffff";
            
            indexToScroll =  [self.collectionElements count];
            indexToScroll = indexToScroll - 2;
            if( indexToScroll < 0){
                indexToScroll = 0;
            }
            NSLog(@"indexToScroll %d ", indexToScroll );
        }else{
			weekInfo.isCurrent = NO;
			weekInfo.foregroundColorCurrentWeek = @"000000";
        }
        
		weekInfo.isFavoriteTeam = existFavoriteTeam;
		weekInfo.isCheckIn = existCheckInMatch;
		
		[self.collectionElements addObject:weekInfo];
		[self.weeksElements addObject:weekInfo];
        
        currentWeekInt = currentWeekInt+1;
    }
	
    return startEndDateOfWeek;
    
}


NSString *prefixImage;

- (void)viewDidLoad{
    [super viewDidLoad];
	self.title = @"Calendar";
	
    if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)){
        prefixImage = @"ipad_";
    }else{
        prefixImage  = @"";
    }
    
     [weekMatch setFont:[UIFont fontWithName:FONT_CARLSBERG_LIGHT size: weekMatch.font.pointSize ]];
     [nbMatchForThisWeekLabel   setFont:[UIFont fontWithName:FONT_CARLSBERG_LIGHT size: nbMatchForThisWeekLabel.font.pointSize ]];
    
	// Do any additional setup after loading the view.
    
    startEndWeek= [self initialisationCalendar];
    
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		CalendarManager *sharedManager = [CalendarManager sharedManager];
		sharedManager.matchOfTheWeek = [MonthViewController getMatchOfCurrentWeek:[startEndWeek objectAtIndex:0] startMonth:[startEndWeek objectAtIndex:1] endDay:[startEndWeek objectAtIndex:2] endMonth:[startEndWeek objectAtIndex:3] year:2013];
        
        
        int nbMatchs =  [sharedManager.matchOfTheWeek count];
        if( nbMatchs == 0 ){
            [nbMatchForThisWeekLabel setHidden:YES];
            [ballIpadImageView setHidden:YES];
        }else{
            [ballIpadImageView setHidden:NO];
            [nbMatchForThisWeekLabel setHidden:NO];
            NSString *matches = (nbMatchs==1)?NSLocalizedString(@"Match", @"Match"):NSLocalizedString(@"Matchs", @"Matchs");
            [nbMatchForThisWeekLabel setText:[NSString stringWithFormat:@"%d %@", nbMatchs, matches ]];
        }
        
		[self.matchWeek reloadData];
	}
    

    [self setupStrings];
    [self addPullToRefreshHeader];
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		WeekViewController *weekView = (WeekViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"weekController"];
		weekView.weekElements = self.weeksElements;
		int page = 0;
		WeekInfo *currentWeekInfo = nil;
		for (page = 0; page < [self.weeksElements count]; page++) {
			currentWeekInfo = [self.weeksElements objectAtIndex:page];
			if (currentWeekInfo.isCurrent) {
				break;
			}
		}
		weekView.appearPage = page;
		[self.navigationController pushViewController:weekView animated:NO];
	}
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
}

- (void)appDidEnterForeground:(NSNotification *)notification {
    NSLog(@"did enter foreground notification");
    // [SVProgressHUD showWithStatus:NSLocalizedString( @"Loading", @"Loading")];
     [self refresh];
}


/*PULL ti REFRESH*/
#define REFRESH_HEADER_HEIGHT 52.0f

- (void)setupStrings{
    textPull = NSLocalizedString(@"pull", nil );
    textRelease = NSLocalizedString(@"release", nil );
    textLoading = NSLocalizedString(@"updating", nil );

    textDate  = @"";
}

- (void)addPullToRefreshHeader {
    refreshHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 - REFRESH_HEADER_HEIGHT, 320, REFRESH_HEADER_HEIGHT)];
    refreshHeaderView.backgroundColor = [UIColor clearColor];
    
    refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, -4, 320, REFRESH_HEADER_HEIGHT)];
    refreshLabel.backgroundColor = [UIColor clearColor];
    refreshLabel.font = [UIFont fontWithName:FONT_CARLSBERG_BOLD size:12.0];
    [refreshLabel setTextColor:[UIColor grayColor]];
    refreshLabel.textAlignment = NSTextAlignmentLeft;
    
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 8, 320, REFRESH_HEADER_HEIGHT)];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.font = [UIFont fontWithName:FONT_CARLSBERG_LIGHT  size:10.0];
    [dateLabel setTextColor:[UIColor grayColor]];
    dateLabel.textAlignment = NSTextAlignmentLeft;
    
    
    refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_pull1"]];
    refreshArrow.frame = CGRectMake(floorf((REFRESH_HEADER_HEIGHT - 15) / 2),
                                    (floorf(REFRESH_HEADER_HEIGHT - 15) / 2),
                                    15, 15);
    [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
    
    refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    refreshSpinner.frame = CGRectMake(floorf(floorf(REFRESH_HEADER_HEIGHT - 20) / 2), floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
    refreshSpinner.hidesWhenStopped = YES;
    
    
    
    [refreshHeaderView addSubview:refreshLabel];
    [refreshHeaderView addSubview:dateLabel];
    [refreshHeaderView addSubview:refreshArrow];
    [refreshHeaderView addSubview:refreshSpinner];
    
    [self.allMonthCollectionView addSubview:refreshHeaderView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (isLoading) return;
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (isLoading) {
        // Update the content inset, good for section headers
        if (scrollView.contentOffset.y > 0)
            self.allMonthCollectionView.contentInset = UIEdgeInsetsZero;
        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
            self.allMonthCollectionView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (isDragging && scrollView.contentOffset.y < 0) {
        // Update the arrow direction and label
        [UIView animateWithDuration:0.25 animations:^{
            if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
                // User is scrolling above the header
                refreshLabel.text = textRelease;
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            } else {
                // User is scrolling somewhere within the header
                refreshLabel.text = textPull;
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
            }
        }];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isLoading) return;
    isDragging = NO;
    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT) {
        // Released above the header
        [self startLoading];
    }
}

- (void)startLoading {
    isLoading = YES;
    
    // Show the header
    [UIView animateWithDuration:0.3 animations:^{
        self.allMonthCollectionView.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
        
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:textLoading];
        NSRange matchRange = [textLoading rangeOfString: textLoading];
        [attrString addAttribute:NSForegroundColorAttributeName value:[Util colorFromHexString: COLOR_Vibrant_green ] range:matchRange];
        refreshLabel.attributedText = attrString;
        refreshArrow.hidden = YES;
        [refreshSpinner startAnimating];
    }];
    
    // Refresh action!
    [self refresh];
}

- (void)stopLoading {
    isLoading = NO;
    
    // Hide the header
    [UIView animateWithDuration:0.3 animations:^{
        self.allMonthCollectionView.contentInset = UIEdgeInsetsZero;
        [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    }
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(stopLoadingComplete)];
                     }];
}

- (void)stopLoadingComplete {
    // Reset the header
    refreshLabel.text = textPull;
    refreshArrow.hidden = NO;
    [refreshSpinner stopAnimating];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
     textDate = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"lastUpdate", nil ), [formatter stringFromDate:[NSDate date]]];
    [dateLabel setText:textDate];
    
	dispatch_async(dispatch_get_main_queue(), ^{
		[allMonthCollectionView reloadData  ];
		
		[allMonthCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow: indexToScroll inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO ];
		
	});
	
}

- (void)refresh {
    // This is just a demo. Override this method with your custom reload action.
    // Don't forget to call stopLoading at the end.
//	if( [InitialSlidingViewController connected] ){
//		startEndWeek = [self initialisationCalendar];
//    }else{
//        UIAlertView *alertView = [[UIAlertView alloc]
//                                  initWithTitle:@"Error"
//                                  message:NSLocalizedString(@"noConnection", @"noConnection")
//                                  delegate:self
//                                  cancelButtonTitle:@"Ok"
//                                  otherButtonTitles:nil];
//        [alertView show];
//    }
//	
//    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:1.0];
}
/*PULL to Refresh*/


+(NSString *)getWeekName:(NSString *)startDay startMonth:(NSString *)startMonth endDay:(NSString *)endDay endMonth:(NSString *)endMonth {
    
    NSString *startMonthShortName = [NSString stringWithFormat:@"monthShort-%@", startMonth ];
    NSString *endMonthShortName = [NSString stringWithFormat:@"monthShort-%@", endMonth ];
    NSString *weekName = [NSString stringWithFormat:@"%@ %@ - %@ %@", startDay, NSLocalizedString( startMonthShortName, startMonthShortName), endDay, NSLocalizedString( endMonthShortName, endMonthShortName) ];
    return weekName;
}


+ (NSMutableArray *) getMatchOfCurrentWeek:(NSString *)startDay startMonth:(NSString *)startMonth endDay:(NSString *)endDay endMonth:(NSString *)endMonth year:(int) year {
    
    nbOfDayMonthbyMonth = [[NSArray alloc]
                           initWithObjects:@"0",@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31",nil];
    NSMutableArray *matchOfWeekCurrent  =[[NSMutableArray alloc] init];
    
    int startDayInt = [startDay intValue];
    int endDayInt = [endDay intValue];
    int startMonthInt = [startMonth integerValue];
    int endMonthInt = [endMonth integerValue];
    
    NSString *dateCurrent;

    if(endMonthInt == startMonthInt){

        while (startDayInt <= endDayInt){
            
            if(startMonthInt <10){
                if(startDayInt<10){
                    dateCurrent    = [[NSString alloc] initWithFormat:@"%d-0%d-0%d",year, startMonthInt, startDayInt];
                }
                else {
                    dateCurrent    = [[NSString alloc] initWithFormat:@"%d-0%d-%d",year, startMonthInt, startDayInt];
					
                }
            }
            else{
                if(startDayInt<10){
                    dateCurrent    = [[NSString alloc] initWithFormat:@"%d-%d-0%d",year, startMonthInt, startDayInt];
                }
                else {
					
					dateCurrent    = [[NSString alloc] initWithFormat:@"%d-%d-%d",year, startMonthInt, startDayInt];
                }
            }
            
            NSLog(@"Date current : %@",dateCurrent);
            
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
            NSMutableArray *tab = [[NSMutableArray alloc] init];;
            NSMutableArray *tab2 = [[NSMutableArray alloc] initWithCapacity:[tab count]];
            
            for( NSDictionary *dict in tab ){
                
                NSMutableDictionary *m = [dict mutableCopy];
                [m setValue:dateCurrent forKey:@"day"];
                [tab2 addObject:m];
            }
            
            NSArray *datesOrdered = [tab2 sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
            
            [matchOfWeekCurrent addObjectsFromArray:datesOrdered];
            
            startDayInt ++;
			
        }
    }
    else {
        id nbDay = [nbOfDayMonthbyMonth objectAtIndex:startMonthInt];
        int nbDayMonth = [nbDay integerValue];
        NSLog(@"nbOfDay : %d",nbDayMonth);
        
        while (startDayInt <= nbDayMonth){
            
            if(startMonthInt <10){
                if(startDayInt<10){
                    dateCurrent    = [[NSString alloc] initWithFormat:@"%d-0%d-0%d", year, startMonthInt, startDayInt];
                    NSLog(@"date current %@", dateCurrent);
					
                }
                else {
                    
                    if(startMonthInt >9){
                    dateCurrent    = [[NSString alloc] initWithFormat:@"%d-%d-%d",year, startMonthInt, startDayInt];
                    NSLog(@"date current %@", dateCurrent);
                    }
                    else{
                        
                        dateCurrent    = [[NSString alloc] initWithFormat:@"%d-0%d-%d",year, startMonthInt, startDayInt];
                        NSLog(@"date current %@", dateCurrent);
                    }
					
                    
                }
            }
            
            else{
                if(startMonthInt<10){
                    dateCurrent    = [[NSString alloc] initWithFormat:@"%d-0%d-0%d",year, startMonthInt, startDayInt];
                    NSLog(@"date current %@", dateCurrent);
					
                }
                else {
                    
                    dateCurrent    = [[NSString alloc] initWithFormat:@"%d-%d-%d",year, startMonthInt, startDayInt];
                    NSLog(@"date current %@", dateCurrent);
					
                }
            }
            
       /*     NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
            NSArray *datesOrdered = [[[[InitialSlidingViewController getCalendarJSON] objectForKey:@"dates"] objectForKey: dateCurrent ] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
            for( NSDictionary *dict in datesOrdered ){
                NSMutableDictionary *dict2 = (NSMutableDictionary *)dict;
                [dict2 setObject:dateCurrent forKey:@"dateCurrent"];
            }
*/
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
            NSMutableArray *tab = [[NSMutableArray alloc] init];;
            NSMutableArray *tab2 = [[NSMutableArray alloc] initWithCapacity:[tab count]];
            
            for( NSDictionary *dict in tab ){
                
                NSMutableDictionary *m = [dict mutableCopy];
                [m setValue:dateCurrent forKey:@"day"];
                [tab2 addObject:m];
            }
            
            NSArray *datesOrdered = [tab2 sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
            
            [matchOfWeekCurrent addObjectsFromArray:datesOrdered];
            
            startDayInt ++;
            
        }
        
        
        startDayInt = 1;
        
        while (startDayInt <= endDayInt){
            
            
            
            if(endMonthInt <10){
                
                if(startDayInt<10){
                    dateCurrent    = [[NSString alloc] initWithFormat:@"%d-0%d-0%d",year, endMonthInt, startDayInt];
                    NSLog(@"date current %@", dateCurrent);
                }
                else {
                    dateCurrent    = [[NSString alloc] initWithFormat:@"%d-%d-%d",year, endMonthInt, startDayInt];
                    NSLog(@"date current %@", dateCurrent);
                }
            }
            else{
                if(startDayInt<10){
                    dateCurrent    = [[NSString alloc] initWithFormat:@"%d-%d-0%d",year, endMonthInt, startDayInt];
                    NSLog(@"date current %@", dateCurrent);
                }
                else {
                    
                    dateCurrent    = [[NSString alloc] initWithFormat:@"%d-%d-%d",year, endMonthInt, startDayInt];
                    NSLog(@"date current %@", dateCurrent);
                    
                }
            }
			
			
         /*
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
            NSArray *datesOrdered = [[[[InitialSlidingViewController getCalendarJSON] objectForKey:@"dates"] objectForKey: dateCurrent ] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
            for( NSDictionary *dict in datesOrdered ){
                NSMutableDictionary *dict2 = (NSMutableDictionary *)dict;
                [dict2 setObject:dateCurrent forKey:@"dateCurrent"];
            }
*/
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
            NSMutableArray *tab = [[NSMutableArray alloc] init];
            NSMutableArray *tab2 = [[NSMutableArray alloc] initWithCapacity:[tab count]];
            
            for( NSDictionary *dict in tab ){
                
                NSMutableDictionary *m = [dict mutableCopy];
                [m setValue:dateCurrent forKey:@"day"];
                [tab2 addObject:m];
            }
            
            NSArray *datesOrdered = [tab2 sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
            
            [matchOfWeekCurrent addObjectsFromArray:datesOrdered];
            
            startDayInt ++;
            
        }
		
        
        
        
        
        
    }
	
    return matchOfWeekCurrent;
    
    
    
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
    
//    isCurrentPageCalendar = false;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self initShareAndCarlsbergMenu];
    
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		CGRect frame = self.matchWeek.frame;
		CalendarManager *sharedManager = [CalendarManager sharedManager];
		frame.size.height = [sharedManager.matchOfTheWeek count]*50;
		matchWeek.frame = frame;
	}
    
//    isCurrentPageCalendar = true;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
	
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"unlockScreen" ];

}

-(void)viewWillAppear:(BOOL)animated    {
    [super viewWillAppear:animated];
	
	dispatch_async(dispatch_get_main_queue(), ^{
    @try {
       
           NSLog(@"indexToScroll %d ", indexToScroll);
            [allMonthCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow: indexToScroll inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO ];
  
    } @catch (NSException *e) {
        NSLog(@"Exception trying to scroll.");
    } @finally {
        
    }
              });
}

-(void)hideMenuIfNoHidden {
//    if( ![socialAndSharingMenuViewController.view isHidden ] ){
//        [Util hideMenu:socialAndSharingMenuViewController.view withX:[Util getXStartMenu: self ]  withY:0];
//        [strikrButton setImage:[UIImage imageNamed:@"logo_strikr_off.png"] forState:UIControlStateNormal ];
//    }
}
//-(void)initShareAndCarlsbergMenu{
//    if( socialAndSharingMenuViewController == nil ){
//        socialAndSharingMenuViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"socialAndShareMenu"];
//    }
//    
//    if( ![socialAndSharingMenuViewController isViewLoaded] || !socialAndSharingMenuViewController.view.window ){
//        [self.mainView addSubview:socialAndSharingMenuViewController.view];
//
//        [socialAndSharingMenuViewController.view setFrame:CGRectMake([Util getXStartMenu: self ] , -SOCIAL_MENU_SIZE, 320 ,SOCIAL_MENU_SIZE)];
//        [socialAndSharingMenuViewController.view setHidden:YES ];
//    }
//    
//}

//- (IBAction)carlsbergMenu:(id)sender{
//    
//    if( [socialAndSharingMenuViewController.view isHidden] ){
//        [self.view addGestureRecognizer:self.slidingViewController.panGesture];
//        self.slidingViewController.panGesture.delegate = self;
//
//        [Util showMenu:socialAndSharingMenuViewController.view withX:[Util getXStartMenu: self ]  withY:0];
//        [strikrButton setImage:[UIImage imageNamed:@"logo_strikr_on.png"] forState:UIControlStateNormal ];
//    }else{
//        [Util hideMenu:socialAndSharingMenuViewController.view withX:[Util getXStartMenu: self ] withY:0];
//
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
//            }
//        }
//    }else{
//        [self hideMenuIfNoHidden];
//        if( self.slidingViewController.topViewController.view.frame.origin.x == 0 ){
//            [self.view removeGestureRecognizer:self.slidingViewController.panGesture];
//        }
//        
//    }
//    return YES;
//}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touch began ") ;
//      [self hideMenuIfNoHidden];
//    if( self.slidingViewController.topViewController.view.frame.origin.x == 0 ){
//        [self.view removeGestureRecognizer:self.slidingViewController.panGesture];
//    }
//}
//- (IBAction)revealMenu:(id)sender{
//    [self hideMenuIfNoHidden];
//    if( self.slidingViewController.topViewController.view.frame.origin.x == 0 ){
//         [self.view addGestureRecognizer:self.slidingViewController.panGesture];
//        self.slidingViewController.panGesture.delegate = self;
//        [self.slidingViewController anchorTopViewTo:ECRight];
//    }else{
//        [self.slidingViewController resetTopView];
//    }
//}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    //return [nbMatchLabel.text intValue];
	CalendarManager *sharedManager = [CalendarManager sharedManager];
    return  [sharedManager.matchOfTheWeek count];
    
    
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width, 0)];
    
    
    return headerView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ){
        if( UIDeviceOrientationIsPortrait(self.interfaceOrientation) ){
             return 80.0f;
        }else{
              return 50.0f;
        }
    }else{
         return 50.0f; 
    }
  
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
//    CheckInMatchCell *myCell = ( CheckInMatchCell * )cell;
//    
//    if(  [myCell.goMatchImage isHidden] ){
//        cell.backgroundColor = [Util colorFromHexString:COLOR_PLAYER_NO_TWITTER];
//    }else{
//        cell.backgroundColor = [Util colorFromHexString:@"FFFFFF"];
//    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"Match on day  %d ", indexPath.row );
//    
//    [self hideMenuIfNoHidden];
//    
//    
//    static NSString *tableCellIdentifier = @"checkInCell";
//    CheckInMatchCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCellIdentifier];
//    CalendarManager *sharedManager = [CalendarManager sharedManager];
//    
//    
//    
//	
//    NSString *matchId = [[sharedManager.matchOfTheWeek objectAtIndex:indexPath.row ] objectForKey:@"id" ];
//    NSString *team_home_id = [[sharedManager.matchOfTheWeek objectAtIndex:indexPath.row ] objectForKey:@"team_home" ];
//    NSString *team_ext_id = [[sharedManager.matchOfTheWeek objectAtIndex:indexPath.row ] objectForKey:@"team_ext" ];
//    
//    NSArray *teams = [[InitialSlidingViewController getTeamsJSON] objectForKey:@"teams"];
//    
//    NSDictionary *homeTeam;
//    NSDictionary *extTeam;
//    
//    for( id team in teams ){
//        NSString *currentId = [team objectForKey:@"id"];
//        if( [currentId isEqualToString:team_home_id ]){
//            homeTeam = team;
//            [cell.homeAbbrLabel setText:[team objectForKey:@"abbr" ]];
//        }else if( [currentId isEqualToString:team_ext_id ]){
//            extTeam = team;
//            [cell.extAbbrLabel setText:[team objectForKey:@"abbr" ]];
//        }
//        
//    }
//    
//    cell.homeTeam = homeTeam;
//    cell.extTeam = extTeam;
//    cell.matchId = matchId;
//    
//    if( [ MyCheckInsViewController isChecked:matchId ] ){
//        [cell.checkedImage setHidden:NO];
//    }else{
//        [cell.checkedImage setHidden:YES];
//    }
//    
//    NSString *dateTime = [[sharedManager.matchOfTheWeek objectAtIndex:indexPath.row] objectForKey:@"day" ];
//    
//    
//    NSLog(@"Date ****  %@ ", dateTime );
//    //[cell.timeLabel setText:dateTime];
//    
//    NSString *dateHour = [[sharedManager.matchOfTheWeek objectAtIndex:indexPath.row] objectForKey:@"date" ];
//
//    [cell.timeLabel setText: [Util getLocalDateFromUTCDate:dateHour withFormat:@"HH:mm" ]];
//    [cell.stadiumLabel setText:[[sharedManager.matchOfTheWeek objectAtIndex:indexPath.row] objectForKey:@"stadium" ]];
//    
//    //a modifier
//    [cell.homeScoreLabel setText:[[sharedManager.matchOfTheWeek objectAtIndex:indexPath.row] objectForKey:@"score_home" ]];
//    [cell.extScoreLabel  setText:[[sharedManager.matchOfTheWeek objectAtIndex:indexPath.row] objectForKey:@"score_ext" ]];
//    
//    
//    
//    NSDateFormatter *date2Formatter = [[NSDateFormatter alloc] init];
//    [date2Formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
//    [date2Formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
//    [date2Formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en-US"]];
//    [date2Formatter setDateFormat:@"yyyy-MM-dd"];
//    NSDate *curDate = [date2Formatter dateFromString: dateTime];
//    [date2Formatter setDateFormat:@"dd MMMM yyyy"];
//    NSString *date = [date2Formatter stringFromDate:curDate ];
//    
//    [cell.dateLabel setText: [date uppercaseString] ];
//    
//    if( [[cell.homeScoreLabel text] isEqualToString:@"" ]){
//        [cell.homeScoreLabel setText: @"-"];
//    }
//    if( [[cell.extScoreLabel text] isEqualToString:@"" ]){
//        [cell.extScoreLabel setText: @"-"];
//    }
//    
//    NSString *homeName = [homeTeam objectForKey:@"name" ];
//    NSString *homeImageName = [NSString stringWithFormat:@"%@.png", homeName ];
//    homeImageName = [homeImageName lowercaseString];
//    homeImageName = [homeImageName stringByReplacingOccurrencesOfString:@" " withString:@"_" ];
//    [cell.homeTeamImage setImage:[UIImage imageNamed: homeImageName ]];
//    
//    NSString *extName = [extTeam objectForKey:@"name" ];
//    NSString *extImageName = [NSString stringWithFormat:@"%@.png", extName ];
//    extImageName = [extImageName lowercaseString];
//    extImageName = [extImageName stringByReplacingOccurrencesOfString:@" " withString:@"_" ];
//    [cell.extTeamImage setImage:[UIImage imageNamed: extImageName ]];
//    
//    
//    NSArray *listMatchs = [[InitialSlidingViewController getLiveMatchsJSON] objectForKey:@"list"];
//    bool isLive = false;
//    for( id matchLive in listMatchs ){
//        NSString *currentMatchId = [matchLive objectForKey:@"id_match"];
//        if( [currentMatchId isEqualToString: matchId] ){
//            isLive = true;
//        }
//    }
//    
//    if( isLive ){
//        [cell.goMatchImage setHidden:NO];
//        [cell setSelectionStyle: UITableViewCellSelectionStyleGray];
//    }else{
//        [cell.goMatchImage setHidden:YES];
//        [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
//    }
//    
//    
//    cell.layer.borderWidth = 0.5f;
//    cell.layer.borderColor = [Util colorFromHexString:COLOR_SEPARATOR ].CGColor;
//
    
    UITableViewCell *cell;
    return cell;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"select match for feed");
    
//    
//    
//    CheckInMatchCell *currenCell = (CheckInMatchCell *) [tableView cellForRowAtIndexPath:indexPath ];
//    
//    if( ![currenCell.goMatchImage isHidden] ){
//         NSLog(@"select match clicc ");
//        
//        [MenuViewController setMatchID:currenCell.matchId];
//        InitialIpadViewController *ctr = (InitialIpadViewController *) self.view.window.rootViewController;
//        [ctr push:ctr.matchesButton];
//        
//    }
	
}





////Gestion rotation
//bool isCurrentPageCalendar ;
//-(void) changeStory{
//    UIStoryboard* story = nil;
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        
//        NSString * storyboardName = [self.storyboard valueForKey:@"name"];
//        NSString * storyName = @"";
//        if (UIDeviceOrientationIsPortrait(self.interfaceOrientation)){
//            NSLog(@"** change to -> portrait  " );
//            storyName = @"iPad-portrait";
//                       if( ![storyboardName isEqualToString:storyName] ){
//                           if( isCurrentPageCalendar ){
//                [[NSUserDefaults standardUserDefaults] setObject:@"monthView" forKey:@"rotateTo" ];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//                           story = [UIStoryboard storyboardWithName:storyName bundle:nil];
//
//                InitialSlidingViewController *initialScene = (InitialSlidingViewController*)[story instantiateViewControllerWithIdentifier:@"init"];
//                self.view.window.rootViewController = initialScene;
//                           }
//            }
//        }else{
//            NSLog(@"** change to -> paysage  " );
//            storyName = @"iPad-paysage";
//     
//            if( ![storyboardName isEqualToString:storyName] ){
//                if(isCurrentPageCalendar ){
//                [[NSUserDefaults standardUserDefaults] setObject:@"monthView" forKey:@"rotateTo" ];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//                story = [UIStoryboard storyboardWithName:storyName bundle:nil];
//
//                InitialIpadViewController *initialScene = (InitialIpadViewController*)[ story instantiateViewControllerWithIdentifier:@"init"];
//                self.view.window.rootViewController = initialScene;
//                [initialScene setSelectedButton:initialScene.calendarButton];
//                }
//            }
//        }
//    }
//}
//
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
- (void) orientationChanged:(NSNotification *)note
{
//    NSLog(@"month orientationChanged %d ",self.interfaceOrientation );
//    
//    NSString *reqSysVer = @"7.0";
//    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
//    if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending){
//        [self performSelector:@selector(changeStory) withObject:nil afterDelay:0.5];
//    }else{
//        [self changeStory];
//    }
}


@end
