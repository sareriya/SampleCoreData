//
//  ViewController.m
//  CoreDataWithSingleView
//
//  Created by Infinium on 8/19/14.
//  Copyright (c) 2014 Infinium. All rights reserved.
//

#import "ViewController.h"
#import "FormFillup.h"

@interface ViewController ()
{
    NSMutableArray *fetchResults;
    NSDateFormatter *dateFormatter;
}
@end

@implementation ViewController

@synthesize managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-YYYY"];
    
//    [tblList registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
//    NSError *error;
//	if (![[self fetchedResultsController] performFetch:&error]) {
//		// Update to handle the error appropriately.
//		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//		exit(-1);  // Fail
//	}
//
   

    if (self.fetchedResultsController.fetchedObjects.count == 0) {
        
    }
    
    [super viewWillAppear:animated];
    
    [self fetchFromCD];
    
    [tblList reloadData];
}
#pragma mark - fetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    managedObjectContext = [[AppDelegate sharedInstance] managedObjectContext];
    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription
//                                   entityForName:@"UserTable" inManagedObjectContext:managedObjectContext];
//    [fetchRequest setEntity:entity];
//    
//   // NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"details.closeDate" ascending:NO];
////    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
//    
// 
//    [fetchRequest setFetchBatchSize:20];
//    
//    NSFetchedResultsController *theFetchedResultsController =
//    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
//                                        managedObjectContext:managedObjectContext sectionNameKeyPath:nil
//                                                   cacheName:nil];
//    self.fetchedResultsController = theFetchedResultsController;
//    _fetchedResultsController.delegate = self;

    NSError *error;
    
    // Test listing all FailedBankInfos from the store
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserTable"
                                              inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
//    for (FailedBankInfo *info in fetchedObjects) {
//        NSLog(@"Name: %@", info.name);
//        FailedBankDetails *details = info.details;
//        NSLog(@"Zip: %@", details.zip);
//    }
    NSLog(@"array =>%@",fetchedObjects);
    
    return _fetchedResultsController;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - Tableview Delegate Method
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [fetchResults count];
}

#pragma mark - TableView Data Source method
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ListCell";
    
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [[fetchResults objectAtIndex:indexPath.row] valueForKey:@"fullname"];
    NSLog(@"%@",[[fetchResults objectAtIndex:indexPath.row] valueForKey:@"bdate"]);
    
    //cell.detailTextLabel.text = [dateFormatter stringFromDate:[[fetchResults objectAtIndex:indexPath.row] valueForKey:@"bdate"]];
    
    cell.detailTextLabel.text = [[[fetchResults objectAtIndex:indexPath.row] valueForKey:@"age"] stringValue];
    return cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObject *managedObject = [fetchResults objectAtIndex:indexPath.row];
        [self.managedObjectContext deleteObject:managedObject];
        [self.managedObjectContext save:nil];
        [fetchResults removeObjectAtIndex:indexPath.row];
        [tblList reloadData];
    }
}
/*-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}*/
#pragma mark - IBAction Method
- (IBAction)btnAddTapped:(id)sender {
    FormFillup *formFill = [self.storyboard instantiateViewControllerWithIdentifier:@"FormFillup"];
    [self.navigationController pushViewController:formFill animated:YES];
    
}

#pragma mark - Private Method
-(void)fetchFromCD{
    NSError *error;
    managedObjectContext = [[AppDelegate sharedInstance] managedObjectContext];
    // Test listing all FailedBankInfos from the store
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserTable"
                                              inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
   // fetchResults =[[NSMutableArray alloc]initWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
    NSArray *result = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
  /*  NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"UserTable.age" ascending:NO];
    
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSLog(@"sort =>%@",[NSArray arrayWithObject:sort]);
    
        [fetchRequest setFetchBatchSize:20];
    
        NSFetchedResultsController *theFetchedResultsController =
        [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                            managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];

        self.fetchedResultsController = theFetchedResultsController;
    NSLog(@"object =>%@",self.fetchedResultsController.fetchedObjects);
    if (self.fetchedResultsController.fetchedObjects.count) {
        NSLog(@"object =>%@",self.fetchedResultsController.fetchedObjects);
    }*/
    
    NSArray *sortDescriptors = @[
                                 [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO]
                                 ];
    
    fetchResults =[[NSMutableArray alloc] initWithArray:[result sortedArrayUsingDescriptors:sortDescriptors]];
    
    NSLog(@"%@ sorted \n", fetchResults);
    
    //NSLog(@"array =>%@",sortedArray);
                                                                      
}
@end
