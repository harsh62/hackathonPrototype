//
//  WeekCell.h
//  StrikR
//
//  Created by Rémi Blanc on 23/07/13.
//  Copyright (c) 2013 Mickael Alléon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeekInfo;
@interface WeekCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *checkedImage;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteImage;
@property (weak, nonatomic) IBOutlet UILabel *nbMatchsLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchsTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateWeekLabel;
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UIImageView *ballImage;

@property (strong, nonatomic) NSString *weekNumber;
@property int year;
@property (strong, nonatomic) NSString *dateWeekString;
@property (strong, nonatomic) WeekInfo *weekInfo;

@end
