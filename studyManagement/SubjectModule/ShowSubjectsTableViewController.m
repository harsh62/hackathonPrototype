//
//  ShowSubjectsTableViewController.m
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import "ShowSubjectsTableViewController.h"

@interface ShowSubjectsTableViewController ()

@end

@implementation ShowSubjectsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.allSubjects = [NSArray arrayWithObjects:
                        @"Subject 1",
                        @"Subject 2",
                        @"Subject 3",
                        @"Subject 4",
                        @"Subject 5",
                        @"Subject 6",
                        @"Subject 7",
                        @"Subject 8",
                        @"Subject 9",
                        @"Subject 10",
                        nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.allSubjects count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"showSubjectCell" forIndexPath:indexPath];
    
    [cell.textLabel setText:[self.allSubjects objectAtIndex:indexPath.row]];
    // Configure the cell...
    if([self.selectedSubjects containsObject:[self.allSubjects objectAtIndex:indexPath.row]]){
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else{
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self.selectedSubjects containsObject:[self.allSubjects objectAtIndex:indexPath.row]]){
        [self.selectedSubjects removeObject:[self.allSubjects objectAtIndex:indexPath.row]];
    }
    else{
        [self.selectedSubjects addObject:[self.allSubjects objectAtIndex:indexPath.row]];
    }
    
    [self.subjectsTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (IBAction)domeButtonSelected:(id)sender {
    [self.modalNavigationDelegate modalControllerDismissedWithValue:self.selectedSubjects];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
