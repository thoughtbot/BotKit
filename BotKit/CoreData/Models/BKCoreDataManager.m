//
//  BKCoreDataManager.m
//  BotKit
//
//  Created by Mark Adams on 9/10/12.
//  Copyright (c) 2014 Mark Adams. All rights reserved.
//

#import "BKCoreDataManager.h"

@interface BKCoreDataManager ()

@property (strong, nonatomic, readwrite) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic, readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic, readwrite) NSManagedObjectModel *managedObjectModel;

@property (copy, nonatomic, readwrite) NSString *storeName;

@end

@implementation BKCoreDataManager

#pragma mark - NSObject;

- (id)init
{
    self = [self initWithSQLiteStoreName:nil];
    
    if (!self)
        return nil;
    
    return self;
}

#pragma mark - Initialization

- (id)initWithSQLiteStoreName:(NSString *)storeName
{
    NSAssert(storeName, @"A valid SQLite store name is required to initialize an instance of this object.");
    
    self = [super init];
    
    if (!self)
        return nil;
    
    _storeName = [[self normalizedStoreNameWithStoreName:storeName] copy];
    
    return self;
}

#pragma mark - Lazy Property Instantiation

- (NSManagedObjectContext *)managedObjectContext
{
    if (!_managedObjectContext)
    {
        NSAssert(self.persistentStoreCoordinator, @"Managed object context could not be created because the persistent store coordinator is nil.");
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    
    return _managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (!_persistentStoreCoordinator)
    {
        NSAssert(self.managedObjectModel, @"Persistent store coordinator could not be created because the managed object model is nil.");
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        NSURL *storeURL = [self.applicationDocumentsDirectory URLByAppendingPathComponent:self.storeName];
        NSDictionary *options = @{ NSInferMappingModelAutomaticallyOption : @(YES), NSMigratePersistentStoresAutomaticallyOption : @(YES) };
        NSError *error = nil;
        
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error])
        {
            NSLog(@"Couldn't add persistent store to coordinator: %@, %@", error, error.userInfo);
            
            return nil;
        }
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (!_managedObjectModel)
    {
        // Using -mergedModelFromBundles does just what it says, searches for .momd files in the supplied bundles.
        // Passing 'nil' falls back to searching all of the bundles in the project.
        _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    }
    
    return _managedObjectModel;
}

#pragma mark - Saving NSManagedObjectContext

- (BOOL)saveContext
{
    NSError *error = nil;
    BOOL saved = [self.managedObjectContext save:&error];

    if (!saved)
        NSLog(@"Error saving context: %@, %@", error, error.userInfo);

    return saved;
}

#pragma mark - App Documents Directory Helper

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Store Path Name Helper

- (NSString *)normalizedStoreNameWithStoreName:(NSString *)storeName
{
    NSAssert(storeName, @"Method was expecting a store name but store name was nil.");
    
    NSString *pathExtension = @".sqlite";
    
    if ([storeName rangeOfString:pathExtension].location == NSNotFound)
        return [storeName stringByAppendingString:pathExtension];
    
    return storeName;
}

@end
