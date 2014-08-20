//
//  ViewController.h
//  CoreDataWithSingleView
//
//  Created by Infinium on 8/19/14.
//  Copyright (c) 2014 Infinium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>
{
    IBOutlet UITableView *tblList;
    NSMutableArray *listArray;
    
}
- (IBAction)btnAddTapped:(id)sender;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic,retain) NSFetchedResultsController *fetchedResultsController;

@end
