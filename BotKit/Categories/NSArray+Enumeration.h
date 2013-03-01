//
//  NSArray+Enumeration.h
//  BotKit
//
//  Created by Gordon Fontenot on 2/27/13.
//  Copyright (c) 2013 thoughtbot. All rights reserved.
//

typedef id (^BKEnumerationBlock)(id object);
typedef BOOL (^BKSelectionBlock)(id object);

@interface NSArray (Enumeration)

- (NSArray *)mappedArrayWithBlock:(BKEnumerationBlock)enumerationBlock;
- (NSArray *)arrayBySelectingObjectsWithBlock:(BKSelectionBlock)selectionBlock;
- (NSArray *)arrayByRejectingObjectsWithBlock:(BKSelectionBlock)selectionBlock;

@end
