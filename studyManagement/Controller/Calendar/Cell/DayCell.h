//
//  DayCell.h
//  StrikR
//
//  Created by Rémi Blanc on 23/07/13.
//  Copyright (c) 2013 Mickael Alléon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayCell : UICollectionViewCell
{
    
    NSString *date;
    
}

@property (nonatomic, retain) NSString *date;

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayIntLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ballImage;
@property (weak, nonatomic) IBOutlet UIImageView *checkedImage;
@property (weak, nonatomic) IBOutlet UILabel *nbMatchLabel;
@property (weak, nonatomic) IBOutlet UIImageView *favTeamImage;
@property (weak, nonatomic) IBOutlet UILabel *matchsTextLabel;

@property (strong, nonatomic) NSString *dateWeekString;

@end
