//
//  DayViewController.h
//  StrikR
//
//  Created by Rémi Blanc on 23/07/13.
//  Copyright (c) 2013 Mickael Alléon. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DayViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>{

    NSString *dateString;
    NSString *date;
    bool isChecked;
    bool isFavorite;
    
}
@property bool isChecked;
@property bool isFavorite;

@property (weak, nonatomic) IBOutlet UIButton *strikrButton;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *dateString;
@property (weak, nonatomic)  UILabel *dayLabel;
@property (weak, nonatomic)  UILabel *dayIntLabel;
@property (weak, nonatomic)  UILabel *matchTextLabel;
@property (weak, nonatomic)  UIImageView *ballImage;

@property (weak, nonatomic) IBOutlet UITableView *listMatchTableView;
@property (weak, nonatomic)  UILabel *nbMatchLabel;

@property (weak, nonatomic) IBOutlet UIView *mainView;

//@property (nonatomic, retain) SocialAndSharingMenuViewController *socialAndSharingMenuViewController;

- (IBAction)revealMenu:(id)sender;
- (IBAction)carlsbergMenu:(id)sender;

@end
