//
//  UIColor+AdjustColor.h
//  CountIt
//
//  Created by Mark Adams on 10/2/12.
//  Copyright (c) 2014 CountIt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (AdjustColor)

/**
 Adjust brightness and saturation by given amount.
 @param amount: A negative amount will darken the color, a positive amount will lighten.
 @return returns the adjusted color.
 */
- (UIColor *)adjustColorByAmount:(CGFloat)amount;

@end
