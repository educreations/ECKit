//
//  UIColor+ECKit.h
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

@import UIKit;


@interface UIColor (ECKit)

+ (UIColor *)ec_colorWithHex:(UInt32)hex;
+ (UIColor *)ec_colorWithHexString:(NSString *)hex;

+ (NSString *)ec_hexStringWithColor:(UIColor *)color;
+ (NSUInteger)ec_integerWithColor:(UIColor *)color;

@end
