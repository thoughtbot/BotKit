//
//  UIView+Frame.h
//  BotKit
//
//  Created by theo on 4/16/13.
//  Copyright (c) 2013 thoughtbot. All rights reserved.
//

CGPoint rectCenter(CGRect rect);
CGRect centerRect(CGRect rect, CGPoint center);
CGRect scaleRect(CGRect rect, CGPoint scale);

CGPoint addPoints(CGPoint p1, CGPoint p2);

CGRect addPointToRect(CGRect rect, CGPoint point);
CGRect addSizeToRect(CGRect rect, CGSize size);

CGRect rectFromPoints(CGPoint top, CGPoint bottom);

CGPoint topLeftCorner(CGRect rect);
CGPoint bottomLeftCorner(CGRect rect);
CGPoint topRightCorner(CGRect rect);
CGPoint bottomRightCorner(CGRect rect);

@interface UIView (Frame)

- (void)setOrigin:(CGPoint)origin;
- (CGPoint)origin;

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;
- (void)setX:(CGFloat)x Y:(CGFloat)y;
- (void)addToX:(CGFloat)amount;
- (void)addToY:(CGFloat)amount;
- (void)addToX:(CGFloat)xAmount Y:(CGFloat)yAmount;

- (void)setSize:(CGSize)size;
- (CGSize)size;

- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setWidth:(CGFloat)width height:(CGFloat)height;
- (void)addToWith:(CGFloat)amount;
- (void)addToHeight:(CGFloat)amount;
- (void)addToWidth:(CGFloat)widthAmount height:(CGFloat)heightAmount;

- (void)setTopLeftPoint:(CGPoint)topLeft bottomRightPoint:(CGPoint)bottomRight;

@end
