//
//  BKCoreDataManager.h
//  BotKit
//
//  Created by Mark Adams on 9/10/12.
//  Copyright (c) 2012 Mark Adams. All rights reserved.
//

@interface BKCoreDataManager : NSObject

@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic, readonly) NSManagedObjectModel *managedObjectModel;

@property (copy, nonatomic, readonly) NSString *storeName;

// Initializes and returns a new instance with a full Core Data stack using the supplied store name.
// If store name is missing a path extension, .sqlite will be appended automagically!
- (id)initWithSQLiteStoreName:(NSString *)storeName;

- (BOOL)saveContext;

@end
