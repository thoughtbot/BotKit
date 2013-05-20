//
//  UIView+Frame.h
//  BotKit
//
//  Created by theo on 4/16/13.
//  Copyright (c) 2013 thoughtbot. All rights reserved.
//

CGPoint BKRectCenter(CGRect rect);
CGRect BKCenterRect(CGRect rect, CGPoint center);
CGRect BKScaleRect(CGRect rect, CGPoint scale);

CGPoint BKAddPoints(CGPoint p1, CGPoint p2);

CGRect BKAddPointToRect(CGRect rect, CGPoint point);
CGRect BKAddSizeToRect(CGRect rect, CGSize size);

CGRect BKRectFromPoints(CGPoint top, CGPoint bottom);

CGPoint BKTopLeftCorner(CGRect rect);
CGPoint BKBottomLeftCorner(CGRect rect);
CGPoint BKTopRightCorner(CGRect rect);
CGPoint BKBottomRightCorner(CGRect rect);

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
