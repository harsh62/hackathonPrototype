//
//  classesHomeCollectionViewController.m
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import "classesHomeCollectionViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "addClassViewController.h"

@interface classesHomeCollectionViewController ()

@end

@implementation classesHomeCollectionViewController

static NSString * const reuseIdentifier = @"customClassCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.classesArray = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.collectionView reloadData];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.classesArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    classesHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
   NSDictionary *classData = [self.classesArray objectAtIndex:indexPath.row];
    NSDictionary *clsData = [classData valueForKey:@"classData"];
    
    [cell.collectionCellLabel setText:[clsData valueForKey:@"className"]];

    [cell.collectionviewDetailCell setText:[clsData valueForKey:@"classStandard"]];

    // Configure the cell
    
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.layer.borderWidth = 1;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"addClass"]){
        addClassViewController *addClassViewcontroller = [segue destinationViewController];
        addClassViewcontroller.pushNavigationDelegate = self;
    }
    else if([segue.identifier isEqualToString:@"showClassData"]){

    }
    else if([segue.identifier isEqualToString:@"teachersSegue"]){

    }
    else if([segue.identifier isEqualToString:@"subjectsSegue"]){

    }
    
}
- (void)modalControllerDismissedWithValue:(NSArray *)valueSelected{
//    switch (selectedButton) {
//        case StudentSelected:
//        {
//            self.selectedStudents = valueSelected;
//        }
//            break;
//        case TeacherSelected:
//        {
//            self.selectedTeachers = valueSelected;
//        }
//            break;
//        case SubjectSelected:
//        {
//            self.selectedSubjects = valueSelected;
//        }
//            break;
//        case StandardSelected:
//        {
//            [self.showStandardDataSelected setTitle:[valueSelected objectAtIndex:0] forState:UIControlStateNormal];
//        }
//            break;
//        default:
//            break;
//    }
    
    [self.classesArray addObject:[valueSelected objectAtIndex:0]];
    
}



@end
