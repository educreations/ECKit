//
//  NSString+ECKit.h
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

@import Foundation;

@interface NSString (ECKit)

+ (NSString *)eckit_base36StringFromInteger:(NSInteger)number;

- (NSData *)eckit_md5Hash;
- (NSString *)eckit_md5HashString;

- (NSString *)eckit_lstrip;
- (NSString *)eckit_lstrip:(NSCharacterSet *)characterSet;

- (NSString *)eckit_rstrip;
- (NSString *)eckit_rstrip:(NSCharacterSet *)characterSet;

@end
