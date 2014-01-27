//
//  BKManagedViewController.m
//  BotKit
//
//  Created by Mark Adams on 9/10/12.
//  Copyright (c) 2014 Mark Adams. All rights reserved.
//

#import "BKManagedViewController.h"

@implementation BKManagedViewController

#pragma mark - Initialization
- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    self = [super initWithNibName:nil bundle:nil];

    if (!self)
        return nil;

    _managedObjectContext = managedObjectContext;

    return self;
}
#pragma mark - Setters
- (void)setFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    _fetchedResultsController.delegate = nil;
    _fetchedResultsController = fetchedResultsController;
    [self performFetch];
}

#pragma mark - Fetch Helpers
- (void)performFetch
{
    if (!self.fetchedResultsController)
        return;

    NSError *error = nil;

    if (![self.fetchedResultsController performFetch:&error])
        NSLog(@"Error performing fetch: %@, %@", error, error.userInfo);
}

@end
