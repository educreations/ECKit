//
//  NSDate+ECKit.h
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

@import Foundation;

@interface NSDate (ECKit)

/**
 * Convert an RFC1123 'Full-Date' string into an NSDate.
 *
 * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.3.1
 */
+ (NSDate *)eckit_dateFromRFC1123:(NSString *)value;

/**
 * Convert an NSDate into an RFC1123 'Full-Date' string.
 *
 * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.3.1
 */
- (NSString *)eckit_rfc1123String;

@end
