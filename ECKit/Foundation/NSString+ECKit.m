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

+ (NSString *)ec_base36StringFromInteger:(NSInteger)number
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

- (NSData *)ec_md5Hash
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];

    return [data ec_md5Hash];
}

- (NSString *)ec_md5HashString
{
    return [[self ec_md5Hash] ec_hexadecimalString];
}

- (NSString *)ec_lstrip
{
    return [self ec_lstrip:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)ec_lstrip:(NSCharacterSet *)characterSet
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

- (NSString *)ec_rstrip
{
    return [self ec_rstrip:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)ec_rstrip:(NSCharacterSet *)characterSet
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
