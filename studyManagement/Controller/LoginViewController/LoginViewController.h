//
//  LoginViewController.h
//  studyManagement
//
//  Created by skapoor on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
//Views
@property (weak, nonatomic) IBOutlet UIView *landingView;
@property (weak, nonatomic) IBOutlet UIView *signUp;
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIImageView *collageImageView;

//Label
@property (weak, nonatomic) IBOutlet UILabel *labelAppName;

//Buttons
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIImageView *teachLogo;

@property (strong, nonatomic) UIImageView *textfieldIcon;

//Actions
- (IBAction)signUp:(id)sender;
- (IBAction)loginButton:(id)sender;


//textFields
@property (weak, nonatomic) IBOutlet UITextField *textFieldUserName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UITextField *textFieldGroupId;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSignUpUserName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSignUpPassword;



@end
