//
//  ProfileViewTableViewController.m
//  studyManagement
//
//  Created by skapoor on 15/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import "ProfileViewTableViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ProfileViewTableViewController ()

@end

@implementation ProfileViewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.blurImage.bounds;
    [self.blurImage addSubview:effectView];
    
    self.profilePicture.layer.cornerRadius = 50;
    [self.profilePicture.layer setMasksToBounds:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
}// became first responder


- (IBAction)profilePictureButtonClicked:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}


#pragma picker view delegates

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.blurImage.bounds;
    [self.blurImage addSubview:effectView];
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.profilePicture.image = chosenImage;
    self.blurImage.image = chosenImage;

    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
