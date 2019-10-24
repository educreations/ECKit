//
//  UIColor+ECKit.h
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

@import UIKit;


@interface UIColor (ECKit)

+ (UIColor *)eckit_colorWithHex:(UInt32)hex;
+ (UIColor *)eckit_colorWithHexString:(NSString *)hex;

+ (NSString *)eckit_hexStringWithColor:(UIColor *)color;
+ (NSUInteger)eckit_integerWithColor:(UIColor *)color;

@end
