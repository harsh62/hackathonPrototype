//
//  LoginViewController.m
//  studyManagement
//
//  Created by skapoor on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import "LoginViewController.h"
#import "Utility.h"
#import "AppConstants.h"
#import <QuartzCore/QuartzCore.h>
#import "LogInSignUp.h"
#import "CoreDataManager.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

CGRect rectLoginButton;
CGRect rectSignUpButton;
CGRect rectLoginView;
CGRect rectSignUpView;
CGRect rectTeachLogo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self designButtons];
    
    
    [self.loginView setFrame:CGRectMake(self.loginView.frame.origin.x, self.view.frame.size.height, self.loginView.frame.size.width, self.loginView.frame.size.width)];
    [self.signUp setFrame:CGRectMake(self.signUp.frame.origin.x, self.view.frame.size.height, self.signUp.frame.size.width, self.signUp.frame.size.width)];
    
    
    rectLoginButton = self.loginButton.frame;
    rectSignUpButton = self.signUpButton.frame;
    rectLoginView = self.loginView.frame;
    rectSignUpView = self.signUp.frame;
    rectTeachLogo = self.teachLogo.frame;
    
}

-(void) viewWillAppear:(BOOL)animated{
    self.loginButton.frame=rectLoginButton;
     self.signUpButton.frame =rectSignUpButton;
     self.loginView.frame =rectLoginView;
     self.signUp.frame =rectSignUpView;
    self.teachLogo.frame = rectTeachLogo;
    
    [self.signUp setAlpha:0];
    [self.loginView setAlpha:0];
    
    [self.loginButton setAlpha:1.0];
    [self.signUpButton setAlpha:1.0];

}

-(void)viewWillDisappear:(BOOL)animated{
    [self.textFieldPassword resignFirstResponder];
    [self.textFieldSignUpPassword resignFirstResponder];
    [self.textFieldSignUpUserName resignFirstResponder];
    [self.textFieldUserName resignFirstResponder];
    [self.textFieldGroupId resignFirstResponder];

}

- (void) designButtons{
    [self.loginButton setBackgroundColor:[Utility colorWithHexString:K_BUTTON_BG_COLOR_HEX]];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginButton.layer.cornerRadius = K_BUTTON_CORNER_RADIUS;
    
    [self.signUpButton setBackgroundColor: [Utility colorWithHexString:K_BUTTON_BG_COLOR_HEX]];
    [self.signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.signUpButton.layer.cornerRadius = K_BUTTON_CORNER_RADIUS;
    
    
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.collageImageView.bounds;
    [self.collageImageView addSubview:effectView];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)validateTextSignUpFields{
    
    if(self.textFieldSignUpUserName.text.length >0 &&self.textFieldSignUpPassword.text.length >0 &&self.textFieldGroupId.text.length >0 ){
        return YES;
    }
    else{
        return NO;
    }
}

-(BOOL)validateTextLoginFields{
    
    if(self.textFieldUserName.text.length >0 &&self.textFieldPassword.text.length >0){
        return YES;
    }
    else{
        return NO;
    }
}

- (IBAction)loginButton:(id)sender {
    
    if(self.loginButton.frame.origin.y != 100){
        [UIView animateWithDuration:0.4
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^
         {
             self.signUpButton.frame = CGRectMake(self.signUpButton.frame.origin.x, 100 , self.signUpButton.frame.size.width, self.signUpButton.frame.size.height);
             self.loginButton.frame = CGRectMake(self.loginButton.frame.origin.x, 100 , 300, self.loginButton.frame.size.height);
             self.teachLogo.frame = CGRectMake(self.teachLogo.frame.origin.x, 20 , self.teachLogo.frame.size.width, self.teachLogo.frame.size.height);
             [self.signUpButton setAlpha:0.0];
             
             //Show sign up View
             [self.loginView setFrame:CGRectMake(self.loginView.frame.origin.x, 170, self.loginView.frame.size.width, self.loginView.frame.size.width)];
             [self.loginView setAlpha:1.0];
             
             self.textFieldUserName.leftViewMode = UITextFieldViewModeAlways;
             [self addIconWithName:@"user91.png"];
             self.textFieldUserName.leftView = self.textfieldIcon;
             
             self.textFieldPassword.leftViewMode = UITextFieldViewModeAlways;
             [self addIconWithName:@"key63.png"];
             self.textFieldPassword.leftView = self.textfieldIcon;
             
         }
                         completion:^(BOOL finished)
         {
             
         }];
    }
    else{
        
        if([self validateTextLoginFields]){
            [self hitLoginWebService];
        }
        else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter all the mandatory Fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
    }
}

- (IBAction)signUp:(id)sender {
    
    
    if(self.signUpButton.frame.origin.y != 100){
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^
         {
             self.signUpButton.frame = CGRectMake(10, 100 , 300, self.signUpButton.frame.size.height);
             self.loginButton.frame = CGRectMake(self.loginButton.frame.origin.x, 100 , self.loginButton.frame.size.width, self.loginButton.frame.size.height);
             self.teachLogo.frame = CGRectMake(self.teachLogo.frame.origin.x, 20 , self.teachLogo.frame.size.width, self.teachLogo.frame.size.height);
             [self.loginButton setAlpha:0.0];
             
             //Show sign up View
             [self.signUp setFrame:CGRectMake(self.signUp.frame.origin.x, 170, self.signUp.frame.size.width, self.signUp.frame.size.width)];
             [self.signUp setAlpha:1.0];
             
             self.textFieldSignUpUserName.leftViewMode = UITextFieldViewModeAlways;
             [self addIconWithName:@"user91.png"];
             self.textFieldSignUpUserName.leftView = self.textfieldIcon;
             
             self.textFieldSignUpPassword.leftViewMode = UITextFieldViewModeAlways;
             [self addIconWithName:@"key63.png"];
             self.textFieldSignUpPassword.leftView = self.textfieldIcon;
             
             self.textFieldGroupId.leftViewMode = UITextFieldViewModeAlways;
             [self addIconWithName:@"multiple25.png"];
             self.textFieldGroupId.leftView = self.textfieldIcon;
             
         }
                         completion:^(BOOL finished)
         {
             
         }];
    }
    else{
        
        if([self validateTextSignUpFields]){
            [self hitSignUpWebService];
        }
        else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter all the mandatory Fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
    }
}

-(void)addIconWithName:(NSString*)imageName {
    self.textfieldIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    self.textfieldIcon.frame = CGRectMake(10.0, 0.0, self.textfieldIcon.image.size.width+10.0, self.textfieldIcon.image.size.height);
    self.textfieldIcon.contentMode = UIViewContentModeCenter;
}


- (void) hitLoginWebService{
    LogInSignUp *loginControl = [[LogInSignUp alloc] init];
    if([loginControl tryToLogInWithUserName:self.textFieldUserName.text Password:self.textFieldPassword.text]){

        [self loginOrSignupSuccessfulForUser:self.textFieldUserName.text];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid Credentials" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

-(void)hitSignUpWebService{
    LogInSignUp *loginControl = [[LogInSignUp alloc] init];
    if([loginControl tryToSignUpWithUserName:self.textFieldSignUpUserName.text Password:self.textFieldSignUpPassword.text andGroupId:self.textFieldGroupId.text]){
        [self loginOrSignupSuccessfulForUser:self.textFieldSignUpUserName.text];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Sign up failed due to an unexpected error!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

-(void)loginOrSignupSuccessfulForUser:(NSString*)userName {
    [self performSegueWithIdentifier:@"loginToContainer" sender:self];
    [[iTeachSingleton sharedManager] setUserName:userName];
}

@end

