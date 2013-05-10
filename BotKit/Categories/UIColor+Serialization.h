//
//  UIColor+AdjustColor.h
//  CountIt
//
//  Created by Mark Adams on 10/2/12.
//  Copyright (c) 2012 thoughtbot. All rights reserved.
//

@interface UIColor (Serialization)

- (NSString *)stringValue;
- (NSString *)hexStringValue;
+ (UIColor *)colorFromString:(NSString *)colorString;
+ (UIColor *)colorFromHexString:(NSString *)hexString;

@end
