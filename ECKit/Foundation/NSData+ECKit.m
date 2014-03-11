//
//  NSData+ECKit.m
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

#import "NSData+ECKit.h"

#include <CommonCrypto/CommonDigest.h>

@implementation NSData (ECKit)

- (NSData *)ec_md5Hash
{
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];

    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(self.bytes, (CC_LONG)self.length, md5Buffer);

    return [NSData dataWithBytes:(const void *)md5Buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)ec_md5HashString
{
    return [[self ec_md5Hash] ec_hexadecimalString];
}

- (NSString *)ec_hexadecimalString
{
    if (self.length < 1) {
        return nil;
    }

    const Byte *bytes = self.bytes;
    NSUInteger numberOfBytes = self.length;

    NSMutableString *s = [NSMutableString stringWithCapacity:numberOfBytes * 2];
	for (NSUInteger i = 0; i < numberOfBytes; i++) {
        [s appendFormat:@"%02x", bytes[i]];
	}

	return [s copy];
}

@end
