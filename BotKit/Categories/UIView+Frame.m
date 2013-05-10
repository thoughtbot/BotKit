//
//  UIView+Frame.m
//  BotKit
//
//  Created by theo on 4/16/13.
//  Copyright (c) 2013 thoughtbot. All rights reserved.
//

#import "UIView+Frame.h"

CGPoint rectCenter(CGRect rect)
{
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

CGRect centerRect(CGRect rect, CGPoint center)
{
    CGRect r = CGRectMake(center.x - rect.size.width/2.0,
                          center.y - rect.size.height/2.0,
                          rect.size.width,
                          rect.size.height);
    return r;
}

CGRect scaleRect(CGRect rect, CGPoint scale)
{
    CGPoint iniCenter = rectCenter(rect);
    CGRect scaled = CGRectMake(0, 0, rect.size.width*scale.x, rect.size.height*scale.y);
    return centerRect(scaled, iniCenter);
}

CGPoint addPoints(CGPoint p1, CGPoint p2)
{
    return CGPointMake(p1.x + p2.x, p1.y + p2.y);
}

CGRect addRects(CGRect r1, CGRect r2)
{
    return CGRectMake(r1.origin.x + r2.origin.x,
                      r1.origin.y + r2.origin.y,
                      r1.size.width + r2.size.width,
                      r1.size.height + r2.size.height);
}

CGRect addPointToRect(CGRect rect, CGPoint point)
{
    return CGRectMake(rect.origin.x + point.x, rect.origin.y + point.y, rect.size.width, rect.size.height);
}

CGRect addSizeToRect(CGRect rect, CGSize size)
{
    return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width + size.width, rect.size.height + rect.size.height);
}

CGRect rectFromPoints(CGPoint top, CGPoint bottom)
{
    return CGRectMake(top.x, top.y, bottom.x - top.x, bottom.y - top.y);
}

CGPoint topLeftCorner(CGRect rect)
{
    return rect.origin;
}

CGPoint topRightCorner(CGRect rect)
{
    return CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect));
}

CGPoint bottomLeftCorner(CGRect rect)
{
    return CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
}

CGPoint bottomRightCorner(CGRect rect)
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
