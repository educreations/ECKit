//
//  NSString+ECKit.h
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

@import Foundation;

@interface NSString (ECKit)

+ (NSString *)ec_base36StringFromInteger:(NSInteger)number;

- (NSData *)ec_md5Hash;
- (NSString *)ec_md5HashString;

- (NSString *)ec_lstrip;
- (NSString *)ec_lstrip:(NSCharacterSet *)characterSet;

- (NSString *)ec_rstrip;
- (NSString *)ec_rstrip:(NSCharacterSet *)characterSet;

@end
