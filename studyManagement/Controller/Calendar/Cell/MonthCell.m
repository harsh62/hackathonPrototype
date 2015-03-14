//
//  MonthCell.m
//  StrikR
//
//  Created by Rémi Blanc on 24/07/13.
//  Copyright (c) 2013 Mickael Alléon. All rights reserved.
//

#import "MonthCell.h"
#import "Constantes.h"

@implementation MonthCell
@synthesize yearLabel, monthLabel;


NSString *colorCurrentWeek = @"ffffff";

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
    [yearLabel setFont:[UIFont fontWithName:FONT_CARLSBERG_BOLD size: yearLabel.font.pointSize ]];
    [monthLabel setFont:[UIFont fontWithName:FONT_CARLSBERG_BOLD size: monthLabel.font.pointSize ]];

}


@end
