//
//  FormFillup.h
//  CoreDataWithSingleView
//
//  Created by Infinium on 8/19/14.
//  Copyright (c) 2014 Infinium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface FormFillup : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *txtFiBDate;
    
    IBOutlet UITextField *txtFiGender;
    IBOutlet UITextField *txtFiAddress;
    IBOutlet UITextField *txtFiName;
}
- (IBAction)BtnSubmitTapped:(id)sender;

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic,retain) NSFetchedResultsController *fetchedResultsController;

@end
