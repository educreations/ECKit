//
//  NSData+ECKit.h
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

@import Foundation;

@interface NSData (ECKit)

- (NSData *)ec_md5Hash;
- (NSString *)ec_md5HashString;

- (NSString *)ec_hexadecimalString;

@end
