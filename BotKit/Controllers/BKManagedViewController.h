//
//  BKManagedViewController.h
//  BotKit
//
//  Created by Mark Adams on 9/10/12.
//  Copyright (c) 2012 Mark Adams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface BKManagedViewController : UIViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end