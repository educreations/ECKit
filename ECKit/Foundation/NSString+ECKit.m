//
//  NSString+ECKit.m
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

#import "NSString+ECKit.h"

#import "NSData+ECKit.h"

@implementation NSString (ECKit)

+ (NSString *)eckit_base36StringFromInteger:(NSInteger)number
{
    static char table[] = "0123456789abcdefghijklmnopqrstuvwxyz";

    NSString *result = [NSString stringWithFormat:@""];

    NSInteger dividend = number;

    do {
        NSInteger modulo = dividend % 36;
        result = [NSString stringWithFormat:@"%c%@", table[modulo], result];

        dividend = dividend / 36;
    } while (dividend > 0);

    return result;
}

- (NSData *)eckit_md5Hash
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];

    return [data eckit_md5Hash];
}

- (NSString *)eckit_md5HashString
{
    return [[self eckit_md5Hash] eckit_hexadecimalString];
}

- (NSString *)eckit_lstrip
{
    return [self eckit_lstrip:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)eckit_lstrip:(NSCharacterSet *)characterSet
{
    NSUInteger i = 0;
    NSUInteger length = [self length];
    for (; i < length; i++) {
        if (![characterSet characterIsMember:[self characterAtIndex:i]]) {
            break;
        }
    }
    if (i == length) {
        return @"";
    }
    return [self substringFromIndex:i];
}

- (NSString *)eckit_rstrip
{
    return [self eckit_rstrip:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)eckit_rstrip:(NSCharacterSet *)characterSet
{
    NSInteger i;
    NSUInteger length = [self length];
    for (i = length - 1; i >= 0; i--) {
        if (![characterSet characterIsMember:[self characterAtIndex:i]]) {
            break;
        }
    }
    if (i < 0) {
        return @"";
    }
    return [self substringToIndex:i + 1];
}

@end
