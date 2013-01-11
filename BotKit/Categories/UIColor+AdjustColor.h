//
//  UIColor+AdjustColor.h
//  CountIt
//
//  Created by Mark Adams on 10/2/12.
//  Copyright (c) 2012 CountIt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (AdjustColor)

- (UIColor *)lighterColorByAmount:(CGFloat)amount;
- (UIColor *)darkerColorByAmount:(CGFloat)amount;

@end
