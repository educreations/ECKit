//
//  UIColor+ECKit.m
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

#import "UIColor+ECKit.h"


@implementation UIColor (ECKit)

+ (UIColor *)ec_colorWithHex:(UInt32)hex
{
	CGFloat red, green, blue;

	red = (hex >> 16) & 0xFF;
	green = (hex >> 8) & 0xFF;
	blue = hex & 0xFF;

    return [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:1.0f];
}

+ (UIColor *)ec_colorWithHexString:(NSString *)hex
{
	const char *cString = [hex cStringUsingEncoding:NSASCIIStringEncoding];
	unsigned int hexadecimal;

	if (cString[0] == '#') {
		hexadecimal = (unsigned int)strtol(cString + 1, NULL, 16);
	} else {
		hexadecimal = (unsigned int)strtol(cString, NULL, 16);
	}

	return [UIColor ec_colorWithHex:hexadecimal];
}

+ (NSString *)ec_hexStringWithColor:(UIColor *)color
{
	const CGFloat *components = CGColorGetComponents([color CGColor]);
	NSString *hexadecimal = [NSString stringWithFormat:@"#%02X%02X%02X",
                             (unsigned int)(255 * components[0]),
                             (unsigned int)(255 * components[1]),
                             (unsigned int)(255 * components[2])];

	return hexadecimal;
}

+ (NSUInteger)ec_integerWithColor:(UIColor *)color
{
    CGFloat red, green, blue;
    if (CGColorGetNumberOfComponents([color CGColor]) == 4) {
        const CGFloat *components = CGColorGetComponents([color CGColor]);
        red = components[0];
        green = components[1];
        blue = components[2];
    } else {
        const CGFloat *components = CGColorGetComponents([color CGColor]);
        red = green = blue = components[0];
    }

    return (((((NSUInteger)roundf(red * 255.0)) << 16) & 0xFF0000) |
            ((((NSUInteger)roundf(green * 255.0)) << 8) & 0xFF00) |
            (((NSUInteger)roundf(blue * 255.0)) & 0xFF));
}

@end
