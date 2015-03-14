//
//  DayCell.m
//  StrikR
//
//  Created by Rémi Blanc on 23/07/13.
//  Copyright (c) 2013 Mickael Alléon. All rights reserved.
//

#import "DayCell.h"
#import "Constantes.h"

@implementation DayCell

@synthesize dayLabel, nbMatchLabel, dayIntLabel,date, matchsTextLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [dayLabel setFont:[UIFont fontWithName:CALENDAR_DAY_FONT size: dayLabel.font.pointSize ]];
    [dayIntLabel setFont:[UIFont fontWithName:FONT_CARLSBERG_LIGHT size: dayIntLabel.font.pointSize ]];
    [nbMatchLabel setFont:[UIFont fontWithName:FONT_CARLSBERG_BOLD size: nbMatchLabel.font.pointSize ]];
    [matchsTextLabel setFont:[UIFont fontWithName:FONT_CARLSBERG_BOLD size: matchsTextLabel.font.pointSize ]];
}


@end
