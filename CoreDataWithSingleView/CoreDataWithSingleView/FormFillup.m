//
//  FormFillup.m
//  CoreDataWithSingleView
//
//  Created by Infinium on 8/19/14.
//  Copyright (c) 2014 Infinium. All rights reserved.
//

#import "FormFillup.h"

@interface FormFillup ()

@end

@implementation FormFillup

@synthesize managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.backBarButtonItem = nil;

    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -TextField Delegate method
-(void)textFieldDidEndEditing:(UITextField *)textField{
        [self.navigationItem setHidesBackButton:NO animated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    return YES;
}

- (IBAction)BtnSubmitTapped:(id)sender {
    [txtFiAddress resignFirstResponder];
    [txtFiBDate resignFirstResponder];
    [txtFiName resignFirstResponder];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    
    NSManagedObjectContext *context = [[AppDelegate sharedInstance] managedObjectContext];
    NSManagedObject *entityObject = [NSEntityDescription insertNewObjectForEntityForName:@"UserTable" inManagedObjectContext:context];
    [entityObject setValue:txtFiName.text forKey:@"fullname"];
    [entityObject setValue:txtFiAddress.text forKey:@"address"];
    [entityObject setValue:[dateFormatter dateFromString:txtFiBDate.text] forKey:@"bdate"];
    [entityObject setValue:txtFiGender.text forKey:@"gender"];
    
    NSDate *Bdate = [dateFormatter dateFromString:txtFiBDate.text];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:Bdate toDate:[NSDate date] options:0];
    [entityObject setValue:[NSNumber numberWithInt:[ageComponents year]] forKey:@"age"];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}
@end
