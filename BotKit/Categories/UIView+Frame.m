//
//  UIView+Frame.m
//  BotKit
//
//  Created by theo on 4/16/13.
//  Copyright (c) 2014 thoughtbot. All rights reserved.
//

#import "UIView+Frame.h"

CGPoint BKRectCenter(CGRect rect)
{
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

CGRect BKCenterRect(CGRect rect, CGPoint center)
{
    CGRect r = CGRectMake(center.x - rect.size.width/2.0,
                          center.y - rect.size.height/2.0,
                          rect.size.width,
                          rect.size.height);
    return r;
}

CGRect BKScaleRect(CGRect rect, CGPoint scale)
{
    CGPoint center = BKRectCenter(rect);
    CGRect scaled = CGRectMake(0, 0, rect.size.width * scale.x, rect.size.height * scale.y);
    return BKCenterRect(scaled, center);
}

CGRect BKScaleRect1D(CGRect rect, float scale)
{
    CGPoint center = BKRectCenter(rect);
    CGRect scaled = CGRectMake(0, 0, rect.size.width * scale, rect.size.height * scale);
    return BKCenterRect(scaled, center);
}

CGPoint BKAddPoints(CGPoint p1, CGPoint p2)
{
    return CGPointMake(p1.x + p2.x, p1.y + p2.y);
}

CGPoint BKSubtractPoints(CGPoint p1, CGPoint p2)
{
    return CGPointMake(p1.x - p2.x, p1.y - p2.y);
}

CGPoint BKScalePoint(CGPoint p1, CGPoint scale)
{
    return CGPointMake(p1.x * scale.x, p1.y * scale.y);
}

CGPoint BKScalePoint1D(CGPoint p1, float scale)
{
    return CGPointMake(p1.x * scale, p1.y * scale);
}

CGRect BKAddRects(CGRect r1, CGRect r2)
{
    return CGRectMake(r1.origin.x + r2.origin.x,
                      r1.origin.y + r2.origin.y,
                      r1.size.width + r2.size.width,
                      r1.size.height + r2.size.height);
}

CGRect BKAddPointToRect(CGRect rect, CGPoint point)
{
    return CGRectMake(rect.origin.x + point.x, rect.origin.y + point.y, rect.size.width, rect.size.height);
}

CGRect BKAddSizeToRect(CGRect rect, CGSize size)
{
    return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width + size.width, rect.size.height + rect.size.height);
}

CGRect BKRectFromPoints(CGPoint top, CGPoint bottom)
{
    return CGRectMake(top.x, top.y, bottom.x - top.x, bottom.y - top.y);
}

CGPoint BKTopLeftCorner(CGRect rect)
{
    return rect.origin;
}

CGPoint BKTopRightCorner(CGRect rect)
{
    return CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect));
}

CGPoint BKBottomLeftCorner(CGRect rect)
{
    return CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
}

CGPoint BKBottomRightCorner(CGRect rect)
{
    return CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
}

@implementation UIView (Frame)

#pragma mark - Origin Manipulation

- (void)setOrigin:(CGPoint)origin
{
    CGRect newFrame = CGRectMake(origin.x, origin.y, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));

    self.frame = newFrame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setX:(CGFloat)x
{
    [self setOrigin:CGPointMake(x, CGRectGetMinY(self.frame))];
}

- (void)setY:(CGFloat)y
{
    [self setOrigin:CGPointMake(CGRectGetMinX(self.frame), y)];
}

- (void)setX:(CGFloat)x Y:(CGFloat)y
{
    [self setOrigin:CGPointMake(x, y)];
}

- (void)addToX:(CGFloat)amount
{
    [self addToX:amount Y:0];
}

- (void)addToY:(CGFloat)amount
{
    [self addToX:0 Y:amount];
}

- (void)addToX:(CGFloat)xAmount Y:(CGFloat)yAmount
{
    CGPoint origin = [self origin];
    origin.x += xAmount;
    origin.y += yAmount;

    [self setOrigin:origin];
}

#pragma mark - Size Manipulation

- (void)setSize:(CGSize)size
{
    CGRect newFrame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), size.width, size.height);

    self.frame = newFrame;
}

- (CGSize)size
{
    return self.bounds.size;
}

- (void)setWidth:(CGFloat)width
{
    [self setSize:CGSizeMake(width, CGRectGetHeight(self.bounds))];
}

- (void)setHeight:(CGFloat)height
{
    [self setSize:CGSizeMake(CGRectGetWidth(self.bounds), height)];
}

- (void)setWidth:(CGFloat)width height:(CGFloat)height
{
    [self setSize:CGSizeMake(width, height)];
}

- (void)addToWith:(CGFloat)amount
{
    [self addToWidth:amount height:0];
}

- (void)addToHeight:(CGFloat)amount
{
    [self addToWidth:0 height:amount];
}

- (void)addToWidth:(CGFloat)widthAmount height:(CGFloat)heightAmount
{
    CGSize size = [self size];
    size.width += widthAmount;
    size.height += heightAmount;

    [self setSize:size];
}

#pragma mark - Other Manipulation

- (void)setTopLeftPoint:(CGPoint)topLeft bottomRightPoint:(CGPoint)bottomRight
{
    CGRect newFrame = CGRectMake(topLeft.x, topLeft.y, bottomRight.x - topLeft.x, bottomRight.y - topLeft.y);
    self.frame = newFrame;
}

@end
