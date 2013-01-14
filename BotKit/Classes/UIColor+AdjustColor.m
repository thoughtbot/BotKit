//
//  UIColor+AdjustColor.m
//  CountIt
//
//  Created by Mark Adams on 10/2/12.
//  Copyright (c) 2012 CountIt. All rights reserved.
//

#import "UIColor+AdjustColor.h"

@implementation UIColor (AdjustColor)

- (UIColor *)adjustColorByAmount:(CGFloat)amount
{
    CGFloat hue, saturation, brightness, alpha;
    
    BOOL converted = [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    if (!converted)
        return nil;
    
    CGFloat adjustmentAmount = fabsf((amount));
    
    if (adjustmentAmount < 0.0f) adjustmentAmount = 0.0f;
    if (adjustmentAmount > 1.0f) adjustmentAmount = 1.0f;
    
    saturation += adjustmentAmount * ((amount<0) - (amount>0));
    brightness += adjustmentAmount * ((amount>0) - (amount<0));
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

@end
