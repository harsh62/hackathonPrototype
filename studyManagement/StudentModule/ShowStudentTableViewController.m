//
//  ShowStudentTableViewController.m
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import "ShowStudentTableViewController.h"

@interface ShowStudentTableViewController ()
{

}
@end

@implementation ShowStudentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.allStudents = [NSArray arrayWithObjects:
                        @"Student 1",
                        @"Student 2",
                        @"Student 3",
                        @"Student 4",
                        @"Student 5",
                        @"Student 6",
                        @"Student 7",
                        @"Student 8",
                        @"Student 9",
                        @"Student 10",
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
    return [self.allStudents count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"showStudentCell" forIndexPath:indexPath];
    
    [cell.textLabel setText:[self.allStudents objectAtIndex:indexPath.row]];
    // Configure the cell...
    if([self.selectedStudents containsObject:[self.allStudents objectAtIndex:indexPath.row]]){
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else{
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self.selectedStudents containsObject:[self.allStudents objectAtIndex:indexPath.row]]){
        [self.selectedStudents removeObject:[self.allStudents objectAtIndex:indexPath.row]];
    }
    else{
        [self.selectedStudents addObject:[self.allStudents objectAtIndex:indexPath.row]];
    }
    
    [self.studentTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
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
    [self.modalNavigationDelegate modalControllerDismissedWithValue:self.selectedStudents];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
