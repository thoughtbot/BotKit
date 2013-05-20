//
//  NSCountedSet+ObjectAccess.h
//  BotKit
//
//  Created by theo on 3/8/13.
//  Copyright (c) 2013 thoughtbot. All rights reserved.
//

/** This category adds a set of methods for easier accessing of objects in an NSCountedSet.
 */

@interface NSCountedSet (ObjectAccess)

///---------------------------------------------------------------------------------------
/// @name Random Object Accessing
///---------------------------------------------------------------------------------------

/** Each object is given equal probability.
 
 @return Returns random object.
 */
- (id)randomObject;

/** Each object is given a probablility based on the count of that object.

 @return Returns random object.
 */
- (id)randomObjectUsingCountsAsWeights;

///---------------------------------------------------------------------------------------
/// @name Object Accessing
///---------------------------------------------------------------------------------------

/** Returns the object with the highest count. If there is a tie then the first object is returned.

 @return Set object.
 */
- (id)mostCommonObject;

/** Returns the object with the lowest count. If there is a tie then the first object is returned.

 @return Set object.
 */
- (id)leastCommonObject;

/** Returns an array with the top N most counted objects from the set. Ordered by count value.
 
 @param numberOfObjects Number of objects returned.
 @return Array of objects.
 */
- (NSArray *)arrayOfMostCommonObjectsWithLimit:(NSInteger)numberOfObjects;

///---------------------------------------------------------------------------------------
/// @name Misc
///---------------------------------------------------------------------------------------

/** Returns the total counts summed for each object.

 @return All counts for all objects.
 */
- (NSInteger)countAllObjects;

/** Returns an array of all the ojects. An object with a count of 10 will have 10 copies in the returned array.

 @return Array of size countAllObjects containing objects.
 */
- (NSArray *)flattenedObjects;

@end
