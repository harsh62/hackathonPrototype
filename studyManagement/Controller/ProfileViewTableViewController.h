//
//  ProfileViewTableViewController.h
//  studyManagement
//
//  Created by skapoor on 15/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewTableViewController : UITableViewController <UIImagePickerControllerDelegate, UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
- (IBAction)profilePictureButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *blurImage;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@end
