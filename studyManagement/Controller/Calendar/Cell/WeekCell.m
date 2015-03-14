//
//  WeekCell.m
//  StrikR
//
//  Created by Rémi Blanc on 23/07/13.
//  Copyright (c) 2013 Mickael Alléon. All rights reserved.
//

#import "WeekCell.h"
#import "Constantes.h"

@implementation WeekCell

@synthesize nbMatchsLabel, dateWeekLabel, matchsTextLabel, colorView;

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
 [super drawRect:rect];
    
    [nbMatchsLabel setFont:[UIFont fontWithName:FONT_CARLSBERG_LIGHT size: nbMatchsLabel.font.pointSize ]];
    [dateWeekLabel setFont:[UIFont fontWithName:FONT_CARLSBERG_LIGHT size: dateWeekLabel.font.pointSize ]];
    [matchsTextLabel setFont:[UIFont fontWithName:FONT_CARLSBERG_LIGHT size: matchsTextLabel.font.pointSize ]];
    
   /* if (self.highlighted) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor(context, 1, 0, 0, 1);
        CGContextFillRect(context, self.bounds);
    }*/

}

-(void)setHighlighted:(BOOL)highlighted
{
    NSLog(@"week cell setHighlighted %d ", highlighted );
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}



@end
