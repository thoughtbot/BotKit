//
//  BKObjectTensor.h
//  BotKit
//
//  Created by theo on 1/18/13.
//  Copyright (c) 2013 thoughtbot. All rights reserved.
//

typedef void (^BKObjectTensorMapIndexPathBlock)(NSIndexPath *);

@interface BKObjectTensor : NSObject

@property (nonatomic, readonly) NSIndexPath *dimensions;

- (id)initWithArray:(NSArray *)array dimensions:(NSIndexPath *)dimensions;
- (id)initWithDimentions:(NSIndexPath *)dimensions;

- (id)objectAtIndex:(NSIndexPath *)index;
- (void)replaceObjectAtIndex:(NSIndexPath *)index withObject:(id)anObject;

- (BOOL)containsIndex:(NSIndexPath *)index;
- (void)mapIndicesToBlock:(BKObjectTensorMapIndexPathBlock)block;

@end
