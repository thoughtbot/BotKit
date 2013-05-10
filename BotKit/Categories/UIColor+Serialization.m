//
//  UIColor+AdjustColor.m
//  CountIt
//
//  Created by Mark Adams on 10/2/12.
//  Copyright (c) 2012 thoughtbot. All rights reserved.
//

#import "UIColor+Serialization.h"

@implementation UIColor (Serialization)

- (NSString *)stringValue
{
    return [NSString stringWithFormat:@"{%0.3f, %0.3f, %0.3f, %0.3f", [self red], [self green], [self blue], [self alpha]];
}

- (NSString *)hexStringValue
{
    CGFloat r = [self.class normalizedColorComponentWithComponent:[self red]];
    CGFloat g = [self.class normalizedColorComponentWithComponent:[self green]];
    CGFloat b = [self.class normalizedColorComponentWithComponent:[self blue]];

    return [NSString stringWithFormat:@"%02X%02X%02X", (int)r * 255, (int)g * 255, (int)b * 255];
}

+ (UIColor *)colorFromString:(NSString *)string
{
    NSString *cleanString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if (![cleanString hasPrefix:@"{"] || ![cleanString hasSuffix:@"}"])
        return nil;

    NSCharacterSet *curlyBraceCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"{}"];
    NSString *colorString = [cleanString stringByTrimmingCharactersInSet:curlyBraceCharacterSet];
    NSArray *componentStrings = [colorString componentsSeparatedByString:@", "];

    if (componentStrings.count != 4)
        return nil;

    return [UIColor colorWithRed:[componentStrings[0] floatValue]
                           green:[componentStrings[1] floatValue]
                            blue:[componentStrings[2] floatValue]
                           alpha:[componentStrings[3] floatValue]];
}

+ (UIColor *)colorFromHexString:(NSString *)hexString
{
    NSString *cleanString = [hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].uppercaseString;

	if (cleanString.length < 6)
        return nil;

	if ([cleanString hasPrefix:@"0X"])
        cleanString = [cleanString substringFromIndex:2];

	if (cleanString.length != 6)
        return nil;

	NSRange range;
	range.location = 0;
	range.length = 2;
	NSString *redString = [cleanString substringWithRange:range];

	range.location = 2;
	NSString *greenString = [cleanString substringWithRange:range];

	range.location = 4;
	NSString *blueString = [cleanString substringWithRange:range];

	unsigned int red, green, blue;
	[[NSScanner scannerWithString:redString] scanHexInt:&red];
	[[NSScanner scannerWithString:greenString] scanHexInt:&green];
	[[NSScanner scannerWithString:blueString] scanHexInt:&blue];

	return [UIColor colorWithRed:((float)red / 255.0f)
						   green:((float)green / 255.0f)
							blue:((float)blue / 255.0f)
						   alpha:1.0f];
}

#pragma - Color Component Helpers

- (CGColorSpaceModel)colorSpaceModel
{
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (NSString *)colorSpaceString
{
    switch ([self colorSpaceModel])
    {
        case kCGColorSpaceModelUnknown:
			return @"kCGColorSpaceModelUnknown";
		case kCGColorSpaceModelMonochrome:
			return @"kCGColorSpaceModelMonochrome";
		case kCGColorSpaceModelRGB:
			return @"kCGColorSpaceModelRGB";
		case kCGColorSpaceModelCMYK:
			return @"kCGColorSpaceModelCMYK";
		case kCGColorSpaceModelLab:
			return @"kCGColorSpaceModelLab";
		case kCGColorSpaceModelDeviceN:
			return @"kCGColorSpaceModelDeviceN";
		case kCGColorSpaceModelIndexed:
			return @"kCGColorSpaceModelIndexed";
		case kCGColorSpaceModelPattern:
			return @"kCGColorSpaceModelPattern";
		default:
			return @"Invalid color space";
    }
}

- (BOOL)hasRGBComponents
{
    BOOL hasComponents = NO;

    if ([self colorSpaceModel] == kCGColorSpaceModelRGB || [self colorSpaceModel] == kCGColorSpaceModelMonochrome)
        hasComponents = YES;

    return hasComponents;
}

- (CGFloat)colorComponentAtIndex:(NSUInteger)index;
{
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    CGFloat component = components[index];

    return component;
}

- (CGFloat)red
{
    return [self colorComponentAtIndex:0];
}

- (CGFloat)green
{
    if ([self colorSpaceModel] == kCGColorSpaceModelMonochrome)
        return [self colorComponentAtIndex:0];
    
    return [self colorComponentAtIndex:1];
}

- (CGFloat)blue
{
    if ([self colorSpaceModel] == kCGColorSpaceModelMonochrome)
        return [self colorComponentAtIndex:0];
    
    return [self colorComponentAtIndex:2];
}

- (CGFloat)alpha
{
    NSUInteger alphaComponentIndex = CGColorGetNumberOfComponents(self.CGColor) - 1;

    return [self colorComponentAtIndex:alphaComponentIndex];
}

+ (CGFloat)normalizedColorComponentWithComponent:(CGFloat)component
{
    CGFloat normalizedComponent = component;
    
    if (component < 0.0f) normalizedComponent = 0.0f;
    if (component > 1.0f) normalizedComponent = 1.0f;

    return normalizedComponent;
}

@end
