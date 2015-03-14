//
//  CoreDataManager.m
//  studyManagement
//
//  Created by Harshdeep  Singh on 14/03/15.
//  Copyright (c) 2015 Harshdeep  Singh. All rights reserved.
//

#import "CoreDataManager.h"
#import "ClassTeach.h"
#import "Group.h"
#import "Students.h"
#import "Subjects.h"
#import "Users.h"
#import "AppDelegate.h"

#define ENTITY_USERS        @"Users"
#define ENTITY_SUBJECTS     @"Subjects"
#define ENTITY_STUDENTS     @"Students"
#define ENTITY_GROUP        @"Group"
#define ENTITY_CLASS_TEACH  @"ClassTeach"


@implementation CoreDataManager
//
//  DataAccessLayer.m
//  YoBu
//
//  Created by Harsh on 23/12/14.
//  Copyright (c) 2014 Harshdeep  Singh. All rights reserved.
//

/*
 *********************************************************************************************************************
 DOCUMENT SAVE - This method stores the list of Documents,returned by the backend
 *********************************************************************************************************************
 */
+ (void)saveUserwithUserName:(NSString*)userName
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    NSError *error;
    @try {
        //Making n entry for the history of the phone call made
        Users *usersModel = (Users*)[NSEntityDescription insertNewObjectForEntityForName:ENTITY_USERS inManagedObjectContext:managedObjectContext];
        usersModel.userName = userName;
        
        [managedObjectContext save:&error];
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception Name: %@ ---> Reason of exception:%@",exception.name,exception.reason);
    }
}

+ (NSArray *)fetchUsers{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    NSError *error;
    @try {
        //Making an entry in order to priorotize the favorite contact
        NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_USERS
                                                  inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        
        NSArray * frequentUsersArray = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        return frequentUsersArray;
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception Name: %@ ---> Reason of exception:%@",exception.name,exception.reason);
    }
}

/*
 *********************************************************************************************************************
 DOCUMENT SAVE - This method stores the list of Documents,returned by the backend
 
 NSDictionary *dictOfClass = @{
 @"className":self.classNameTextField.text,
 @"classStandard":self.showStandardDataSelected.titleLabel.text
 };
 NSDictionary *dictionaryOfClass = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:dictOfClass,self.selectedStudents,self.selectedSubjects, self.selectedTeachers, nil] forKeys:[NSArray arrayWithObjects:@"classData",@"students",@"subjects",@"teachers", nil]];
 
 
 *********************************************************************************************************************
 */
+ (void)saveClassTeach:(NSDictionary *)classDictionary
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    NSError *error;
    @try {
        //Making n entry for the history of the phone call made
        ClassTeach *classTeachModel = (ClassTeach*)[NSEntityDescription insertNewObjectForEntityForName:ENTITY_CLASS_TEACH
                                                                  inManagedObjectContext:managedObjectContext];
        classTeachModel.teachClassName = [(NSDictionary *)[classDictionary valueForKey:@"classData"] valueForKey:@"className"];
        classTeachModel.teachClassStandard = [(NSDictionary *)[classDictionary valueForKey:@"classData"] valueForKey:@"classStandard"];
        
        NSArray *students =[classDictionary valueForKey:@"students"];
        NSArray *subjects =[classDictionary valueForKey:@"subjects"];
        NSArray *teachers =[classDictionary valueForKey:@"teachers"];
        
        
        [managedObjectContext save:&error];
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception Name: %@ ---> Reason of exception:%@",exception.name,exception.reason);
    }
}

+ (void)addSubjectWithName:(NSString *)subject{
    
}

/*
+ (NSArray *)fetchRecentlyDialedContacts{
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedInstance] managedObjectContext];
    NSError *error;
    @try {
        //Making an entry in order to priorotize the favorite contact
        NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_DIALED_NUMBERS
                                                  inManagedObjectContext:managedObjectContext];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"callDateAndTime" ascending:NO selector:@selector(localizedStandardCompare:)]; // ascending YES = start with earliest date
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [fetchRequest setEntity:entity];
        [fetchRequest setSortDescriptors:sortDescriptors];
        NSArray * frequentContactsArray = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        return frequentContactsArray;
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception Name: %@ ---> Reason of exception:%@",exception.name,exception.reason);
    }
}

+ (NSArray *)fetchAllFrequentContacts{
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedInstance] managedObjectContext];
    NSError *error;
    @try {
        //Making an entry in order to priorotize the favorite contact
        NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_FREQUENT_CONTACTS
                                                  inManagedObjectContext:managedObjectContext];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"counter" ascending:NO selector:@selector(localizedStandardCompare:)]; // ascending YES = start with earliest date
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [fetchRequest setEntity:entity];
        [fetchRequest setSortDescriptors:sortDescriptors];
        NSArray * frequentContactsArray = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        return frequentContactsArray;
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception Name: %@ ---> Reason of exception:%@",exception.name,exception.reason);
    }
}





+ (void)saveCustomSearchForDigit:(NSString*)digit withAlphabets:(NSString*)alphabets
{
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedInstance] managedObjectContext];
    NSError *error;
    @try {
        //Making an entry in order to priorotize the favorite contact
        NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_CUSTOM_SEARCH
                                                  inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"digit == %@",digit];
        [fetchRequest setPredicate:predicate];
        NSArray * digitsArray = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        if([digitsArray count]>0){
            CustomSearchAlphabets *digitModel = [digitsArray objectAtIndex:0];
            digitModel.containingAlphabets = alphabets;
        }
        else{
            CustomSearchAlphabets *digitModel = (CustomSearchAlphabets*)[NSEntityDescription insertNewObjectForEntityForName:ENTITY_CUSTOM_SEARCH inManagedObjectContext:managedObjectContext];
            digitModel.digit = digit;
            digitModel.containingAlphabets = alphabets;
        }
        [managedObjectContext save:&error];
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception Name: %@ ---> Reason of exception:%@",exception.name,exception.reason);
    }
}

+ (void)saveContactWithName:(NSString*)name andPhoneNumber:(NSString*)phoneNumber havingRecordIdAs:(NSString *)recordId{
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedInstance] managedObjectContext];
    NSError *error;
    @try {
        //Making an entry in order to priorotize the favorite contact
        NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_ADDRESS_BOOK
                                                  inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@ AND phoneNumber == %@ AND recordId == %@",name,phoneNumber,recordId];
        [fetchRequest setPredicate:predicate];
        NSArray * contactsArray = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        if([contactsArray count]>0){
        }
        else{
            AddressBook *contact = (AddressBook*)[NSEntityDescription insertNewObjectForEntityForName:ENTITY_ADDRESS_BOOK inManagedObjectContext:managedObjectContext];
            contact.name = name;
            contact.phoneNumber = phoneNumber;
            contact.recordId = recordId;
        }
        [managedObjectContext save:&error];
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception Name: %@ ---> Reason of exception:%@",exception.name,exception.reason);
    }
}



+ (NSString *)fetchCustomAlphabetsForDigit:(NSString*)digit
{
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedInstance] managedObjectContext];
    NSError *error;
    @try {
        //Making an entry in order to priorotize the favorite contact
        NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_CUSTOM_SEARCH
                                                  inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"digit == %@",digit];
        [fetchRequest setPredicate:predicate];
        NSArray * digitsArray = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        if([digitsArray count]>0){
            CustomSearchAlphabets *customSearchAlphabetsModel =  [digitsArray objectAtIndex:0];
            return customSearchAlphabetsModel.containingAlphabets;
        }
        else{
            return @"";
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception Name: %@ ---> Reason of exception:%@",exception.name,exception.reason);
    }
}

+ (void)checkAndUpdateTabelWithDefaultAlphabets{
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedInstance] managedObjectContext];
    NSError *error;
    @try {
        //Making an entry in order to priorotize the favorite contact
        NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_CUSTOM_SEARCH
                                                  inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        NSArray * digitsArray = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"DefaultEnglishAlphabets" ofType:@"plist"];
        NSArray *arrayOfDefaultAlphabets = [[NSArray alloc] initWithContentsOfFile:path];
        
        if([arrayOfDefaultAlphabets count] != [digitsArray count]){
            for(NSDictionary *dictionaryInPlist in arrayOfDefaultAlphabets){
                [self saveCustomSearchForDigit:[dictionaryInPlist valueForKey:@"digit"] withAlphabets:[dictionaryInPlist valueForKey:@"containingAlphabets"]];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception Name: %@ ---> Reason of exception:%@",exception.name,exception.reason);
    }
}


+ (void)saveFavoriteContactsWithName:(NSString*)name andWithPhoneNumber:(NSString*)phoneNumber andWithImageData:(NSData *) imageData{
    
    
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedInstance] managedObjectContext];
    NSError *error;
    @try {
        //Making an entry in order to priorotize the favorite contact
        NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_FAVORITE_CONTACTS
                                                  inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@ AND phoneNumber == %@",name,phoneNumber];
        [fetchRequest setPredicate:predicate];
        NSArray * frequentContactsArray = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        if([frequentContactsArray count]>0){
            FavoriteContacts *favoriteContactsModel = [frequentContactsArray objectAtIndex:0];
            favoriteContactsModel.name = name;
            favoriteContactsModel.phoneNumber = phoneNumber;
            favoriteContactsModel.image = imageData;
        }
        else{
            FavoriteContacts *favoriteContactsModel = (FavoriteContacts*)[NSEntityDescription insertNewObjectForEntityForName:ENTITY_FAVORITE_CONTACTS inManagedObjectContext:managedObjectContext];
            favoriteContactsModel.name = name;
            favoriteContactsModel.phoneNumber = phoneNumber;
            if(imageData != nil)
                favoriteContactsModel.image = imageData;
        }
        [managedObjectContext save:&error];
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception Name: %@ ---> Reason of exception:%@",exception.name,exception.reason);
    }
}


+ (NSArray *)fetchAllFavoriteContacts{
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedInstance] managedObjectContext];
    NSError *error;
    @try {
        //Making an entry in order to priorotize the favorite contact
        NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_FAVORITE_CONTACTS
                                                  inManagedObjectContext:managedObjectContext];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO selector:@selector(localizedStandardCompare:)]; // ascending YES = start with earliest date
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [fetchRequest setEntity:entity];
        [fetchRequest setSortDescriptors:sortDescriptors];
        NSArray * frequentContactsArray = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        return frequentContactsArray;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception Name: %@ ---> Reason of exception:%@",exception.name,exception.reason);
    }
}

+ (NSArray *)fetchAllContacts{
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedInstance] managedObjectContext];
    NSError *error;
    @try {
        //Making an entry in order to priorotize the favorite contact
        NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_ADDRESS_BOOK
                                                  inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        return [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception Name: %@ ---> Reason of exception:%@",exception.name,exception.reason);
    }
}

+ (void)deleteModel:(id)modelToBeDeleted{
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedInstance] managedObjectContext];
    [managedObjectContext deleteObject:modelToBeDeleted];
}
 */
@end
