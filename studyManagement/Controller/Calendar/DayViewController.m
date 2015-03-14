//
//  DayViewController.m
//  StrikR
//
//  Created by Rémi Blanc on 23/07/13.
//  Copyright (c) 2013 Mickael Alléon. All rights reserved.
//

#import "DayViewController.h"
#import "CloseCell.h"
#import "DayCell.h"
#import "Util.h"
#import "Constantes.h"


@interface DayViewController ()

@end

@implementation DayViewController

@synthesize isChecked, ballImage, nbMatchLabel, dayIntLabel, dayLabel, date,isFavorite, matchTextLabel, strikrButton, listMatchTableView, dateString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
    NSLog(@"ViewDidLoad %@ ", self.dayLabel.text );
	// Do any additional setup after loading the view.
    
    listMatchTableView.separatorColor = [UIColor clearColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectItemAtIndexPath %d ", indexPath.row );
    if( indexPath.row == 0 ){
        [self.navigationController popViewControllerAnimated:YES];
    }
            
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    CheckInMatchCell *cell = (CheckInMatchCell *) [tableView cellForRowAtIndexPath:indexPath ];
//    
//    if( ![cell.goMatchImage isHidden] ){
//        
//        [MenuViewController setMatchID: cell.matchId];
//        
//        UITabBarController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstTop"];
//        newTopViewController.selectedViewController = [newTopViewController.viewControllers objectAtIndex:2];
//        self.slidingViewController.topViewController = newTopViewController;
//    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"cellForItemAtIndexPath %ld ", (long)indexPath.row );
    
    if( indexPath.row == 0 ){
        CloseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"closeCell" forIndexPath:indexPath];
        cell.layer.borderWidth=1.0f;
        if( isIPad){
            cell.layer.borderWidth=4.0f;
        }
        
        cell.layer.borderColor=[Util colorFromHexString:@"ffffff"].CGColor;

        [cell.dateStringLabel setText:self.dateString];
        return cell;
    }else{
        DayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dayCell" forIndexPath:indexPath];
        cell.layer.borderWidth=1.0f;
        if( isIPad){
            cell.layer.borderWidth=4.0f;
        }
        
        cell.layer.borderColor=[Util colorFromHexString:COLOR_CURRENT_DAY].CGColor;
        
    //    cell.backgroundColor = [Util colorFromHexString: @"ffffff" ];
        [cell.dayIntLabel setText: self.dayIntLabel.text];
        [cell.dayLabel setText: self.dayLabel.text];
        [cell.nbMatchLabel setText: self.nbMatchLabel.text];
        [cell.matchsTextLabel setText: self.matchTextLabel.text];
        [cell.checkedImage setHidden: self.isChecked ];
        [cell.favTeamImage setHidden: self.isFavorite];

        
       
        return cell;
    }
    
    
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    if( isIPhone ){
        return CGSizeMake(160, 114);
    }else{
        if ( isPortrait ){
            return CGSizeMake(384 , 240);
        }else {
            return CGSizeMake(205 , 232);
        }
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [nbMatchLabel.text intValue];
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
  if( isIPhone ){
      return 50.0f;
  }else{
      return 105.0f;
  }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    CheckInMatchCell *myCell = ( CheckInMatchCell * )cell;
//    
//    if(  [myCell.goMatchImage isHidden] ){
//         cell.backgroundColor = [Util colorFromHexString:COLOR_PLAYER_NO_TWITTER];
//    }else{
         cell.backgroundColor = [Util colorFromHexString:@"FFFFFF"];
//    }
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Match on day  %ld ", (long)indexPath.row );
    
//    [self hideMenuIfNoHidden];
//   
//    static NSString *tableCellIdentifier = @"checkInCell";
//    CheckInMatchCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCellIdentifier];
//
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
//    NSArray *dates = [[[[InitialSlidingViewController getCalendarJSON] objectForKey:@"dates"] objectForKey: date ] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
//
//    
//                                                                                                                                 
//   // NSArray *dates = [[[InitialSlidingViewController getCalendarJSON] objectForKey:@"dates"] objectForKey: date];
//    NSLog(@"Date: %@ datesArray %@ ",date, dates );
//   
//                        
//    NSString *matchId = [[dates objectAtIndex:indexPath.row ] objectForKey:@"id" ];
//    NSString *team_home_id = [[dates objectAtIndex:indexPath.row ] objectForKey:@"team_home" ];
//    NSString *team_ext_id = [[dates objectAtIndex:indexPath.row ] objectForKey:@"team_ext" ];
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
//    [cell.stadiumLabel setText:[[dates objectAtIndex:indexPath.row] objectForKey:@"stadium" ]];
//    [cell.timeLabel setText: [Util getLocalDateFromUTCDate:[[dates objectAtIndex:indexPath.row] objectForKey:@"date" ] withFormat:@"HH:mm" ]];
//
//    //a modifier
//    [cell.homeScoreLabel setText:[[dates objectAtIndex:indexPath.row] objectForKey:@"score_home" ]];
//    [cell.extScoreLabel  setText:[[dates objectAtIndex:indexPath.row] objectForKey:@"score_ext" ]];
//    
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
//    NSDictionary *currentDict = nil;
//    for( id matchLive in listMatchs ){
//        NSString *currentMatchId = [matchLive objectForKey:@"id_match"];
//        if( [currentMatchId isEqualToString: matchId] ){
//            isLive = true;
//            currentDict = matchLive;
//        }
//    }
//    
//    if( isLive ){
//        [cell.goMatchImage setHidden:NO];
//        [cell setSelectionStyle: UITableViewCellSelectionStyleGray];
//        [cell.homeScoreLabel setText:[currentDict objectForKey:@"score_home" ]];
//        [cell.extScoreLabel  setText:[currentDict objectForKey:@"score_ext" ]];
//
//    }else{
//        [cell.goMatchImage setHidden:YES];
//        [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
//    }
//
//    if( [[cell.homeScoreLabel text] isEqualToString:@"" ]){
//        [cell.homeScoreLabel setText: @"-"];
//    }
//    if( [[cell.extScoreLabel text] isEqualToString:@"" ]){
//        [cell.extScoreLabel setText: @"-"];
//    }
//    
//    cell.layer.borderWidth = 0.5f;
//    if( isIPad){
//        cell.layer.borderWidth=1.0f;
//    }
//    
//    cell.layer.borderColor = [Util colorFromHexString:COLOR_SEPARATOR ].CGColor;
    UITableViewCell *cell;
    return cell;
    
    
    }

//MODULE PARTAGE

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self hideMenuIfNoHidden];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self initShareAndCarlsbergMenu];
//    [InitialSlidingViewController reinitLiveMatch];
    
    
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

-(void)initShareAndCarlsbergMenu{
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
    
}

- (IBAction)carlsbergMenu:(id)sender{
//    if( [socialAndSharingMenuViewController.view isHidden] ){
//        [self.view addGestureRecognizer:self.slidingViewController.panGesture];
//        self.slidingViewController.panGesture.delegate = self;
//
//        
//        [Util showMenu:socialAndSharingMenuViewController.view withX:[Util getXStartMenu: self ]  withY:0];
//        [strikrButton setImage:[UIImage imageNamed:@"logo_strikr_on.png"] forState:UIControlStateNormal ];
//    }else{
//        [Util hideMenu:socialAndSharingMenuViewController.view withX:[Util getXStartMenu: self ]  withY:0];
//        [strikrButton setImage:[UIImage imageNamed:@"logo_strikr_off.png"] forState:UIControlStateNormal ];
//    }
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
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
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touch began ") ;
//    if( self.slidingViewController.topViewController.view.frame.origin.x == 0 ){
//        [self.view removeGestureRecognizer:self.slidingViewController.panGesture];
//    }
}
- (IBAction)revealMenu:(id)sender{
//    [self hideMenuIfNoHidden];
//    if( self.slidingViewController.topViewController.view.frame.origin.x == 0 ){
//        [self.view addGestureRecognizer:self.slidingViewController.panGesture];
//        self.slidingViewController.panGesture.delegate = self;
//
//        [self.slidingViewController anchorTopViewTo:ECRight];
//    }else{
//        [self.slidingViewController resetTopView];
//    }
}



//Gestion rotation

-(void) changeStory{
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
}

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
