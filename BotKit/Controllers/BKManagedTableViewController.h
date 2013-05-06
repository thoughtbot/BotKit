//
//  BKManagedTableViewController.h
//  BotKit
//
//  Created by Mark Adams on 9/10/12.
//  Copyright (c) 2012 Mark Adams. All rights reserved.
//

#import "BKManagedViewController.h"

@interface BKManagedTableViewController : BKManagedViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) BOOL clearsSelectionOnViewWillAppear;

@end
