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

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self designButtons];
    
    
    [self.loginView setFrame:CGRectMake(self.loginView.frame.origin.x, self.view.frame.size.height, self.loginView.frame.size.width, self.loginView.frame.size.width)];
    [self.signUp setFrame:CGRectMake(self.signUp.frame.origin.x, self.view.frame.size.height, self.signUp.frame.size.width, self.signUp.frame.size.width)];
    
}

-(void) viewWillAppear:(BOOL)animated{
    
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

- (IBAction)signUp:(id)sender {
    
    
    if(self.signUpButton.frame.origin.y != 100){
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options: UIViewAnimationOptionCurveLinear
                         animations:^
         {
             self.signUpButton.frame = CGRectMake(self.signUpButton.frame.origin.x, 100 , self.signUpButton.frame.size.width, self.signUpButton.frame.size.height);
             self.loginButton.frame = CGRectMake(self.loginButton.frame.origin.x, 100 , self.loginButton.frame.size.width, self.loginButton.frame.size.height);
             self.teachLogo.frame = CGRectMake(self.teachLogo.frame.origin.x, 20 , self.teachLogo.frame.size.width, self.teachLogo.frame.size.height);
             [self.loginButton setAlpha:0.0];
             
             //Show sign up View
             [self.signUp setFrame:CGRectMake(self.signUp.frame.origin.x, 200, self.signUp.frame.size.width, self.signUp.frame.size.width)];
             [self.signUp setAlpha:1.0];
             
         }
                         completion:^(BOOL finished)
         {
             
         }];
    }
    else{
        
        if([self validateTextSignUpFields]){
            [self performSegueWithIdentifier:@"loginToContainer" sender:self];
        }
        else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter all the mandatory Fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
    }
}

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
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options: UIViewAnimationOptionCurveLinear
                         animations:^
         {
             self.signUpButton.frame = CGRectMake(self.signUpButton.frame.origin.x, 100 , self.signUpButton.frame.size.width, self.signUpButton.frame.size.height);
             self.loginButton.frame = CGRectMake(self.loginButton.frame.origin.x, 100 , self.loginButton.frame.size.width, self.loginButton.frame.size.height);
             self.teachLogo.frame = CGRectMake(self.teachLogo.frame.origin.x, 20 , self.teachLogo.frame.size.width, self.teachLogo.frame.size.height);
             [self.signUpButton setAlpha:0.0];
             
             //Show sign up View
             [self.loginView setFrame:CGRectMake(self.loginView.frame.origin.x, 200, self.loginView.frame.size.width, self.loginView.frame.size.width)];
             [self.loginView setAlpha:1.0];
             
         }
                         completion:^(BOOL finished)
         {
             
         }];
    }
    else{
        
        if([self validateTextLoginFields]){
            [self performSegueWithIdentifier:@"loginToContainer" sender:self];
        }
        else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter all the mandatory Fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
    }
}
@end
