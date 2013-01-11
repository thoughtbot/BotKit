//
//  UIViewController+SegueIdentifier.h
//  BotKit
//
//  Created by Mark Adams on 10/24/12.
//  Copyright (c) 2012 thoughtbot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SegueIdentifier)

+ (NSString *)segueIdentifier;
+ (NSString *)storyboardIdentifier;

@end
