//
//  NSData+ECKit.h
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

@import Foundation;

@interface NSData (ECKit)

- (NSData *)eckit_md5Hash;
- (NSString *)eckit_md5HashString;

- (NSString *)eckit_hexadecimalString;

@end
