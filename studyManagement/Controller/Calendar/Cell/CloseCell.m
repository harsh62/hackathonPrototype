//
//  CloseCell.m
//  StrikR
//
//  Created by Rémi Blanc on 23/07/13.
//  Copyright (c) 2013 Mickael Alléon. All rights reserved.
//

#import "CloseCell.h"
#import "Constantes.h"


@implementation CloseCell

@synthesize dateStringLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization codeUtil.h
//        Util.m
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
  [dateStringLabel setFont:[UIFont fontWithName:FONT_CARLSBERG_LIGHT size: dateStringLabel.font.pointSize ]];
}


@end
