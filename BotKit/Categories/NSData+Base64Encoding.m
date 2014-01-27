//
//  NSData+Base64Encoding.m
//  Kirubot
//
//  Created by Mark Adams on 10/10/12.
//  Copyright (c) 2014 thoughtbot. All rights reserved.
//

#import "NSData+Base64Encoding.h"

@implementation NSData (Base64Encoding)

- (NSString *)base64String
{
    const uint8_t *input = (const uint8_t*)[self bytes];
    NSInteger length = [self length];

    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

    NSMutableData *data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t *output = (uint8_t*)data.mutableBytes;

    NSInteger i;
    
    for (i=0; i < length; i += 3)
    {
        NSInteger value = 0;
        NSInteger j;

        for (j = i; j < (i + 3); j++)
        {
            value <<= 8;

            if (j < length)
                value |= (0xFF & input[j]);
        }

        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] = table[(value >> 18) & 0x3F];
        output[theIndex + 1] = table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
