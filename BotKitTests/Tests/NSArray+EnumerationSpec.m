//
//  NSArray+EnumerationSpec.m
//  BotKit
//
//  Created by Gordon Fontenot on 2/27/13.
//  Copyright 2013 thoughtbot. All rights reserved.
//

#import "NSArray+Enumeration.h"

SPEC_BEGIN(NSArray_EnumerationSpec)
__block NSArray *array = nil;

beforeAll(^{
    array = @[@"foo", @"bar", @"baz"];
});

describe(@"mappedArrayWithBlock:", ^{
    it(@"returns a new array", ^{
        NSArray *newArray = [array mappedArrayWithBlock:^id (id object){ return @YES; }];
        [[newArray shouldNot] equal:array];
    });

    it(@"ignores nil objects", ^{
        NSArray *newArray = [array mappedArrayWithBlock:^id (id object){ return nil; }];
        [[theValue([newArray count]) should] equal:theValue(0)];
    });

    it(@"can perform transformations on the original array", ^{
        NSArray *newArray = [array mappedArrayWithBlock:^id (NSString *string) {
            return [string uppercaseString];
        }];

        [[newArray should] equal:@[@"FOO", @"BAR", @"BAZ"]];
    });
});

SPEC_END


