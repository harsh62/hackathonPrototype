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
    
    
    
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^
     {
        self.signUpButton.frame = CGRectMake(self.signUpButton.frame.origin.x, self.signUpButton.frame.origin.y - 200, self.signUpButton.frame.size.width, self.signUpButton.frame.size.height);
        self.loginButton.frame = CGRectMake(self.loginButton.frame.origin.x, self.loginButton.frame.origin.y - 200, self.loginButton.frame.size.width, self.loginButton.frame.size.height);

    }
                     completion:^(BOOL finished)
     {
         [self.loginButton setHidden:YES];

         NSLog(@"Completed");
         
     }];
    
    
    
}

- (IBAction)loginButton:(id)sender {
}
@end
