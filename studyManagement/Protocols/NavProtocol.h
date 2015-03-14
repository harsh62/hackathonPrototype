//
//  NavProtocol.h
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#ifndef studyManagement_NavProtocol_h
#define studyManagement_NavProtocol_h

@protocol sideNavigationProtocol <NSObject>

- (void)sideNavProfileSelected;

- (void)signOutButtonClicked;

- (void)toDoClicked;

- (void)profileButtonClicked;

- (void)calendarButtonClicked;

- (void)connectButtonClicked;

@end

@protocol modalControllerDelegate <NSObject>

- (void)modalControllerDismissedWithValue:(NSArray *)valueSelected;

@end


#endif
