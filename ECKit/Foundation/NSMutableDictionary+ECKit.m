//
//  NSMutableDictionary+ECKit.m
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

#import "NSMutableDictionary+ECKit.h"

@implementation NSMutableDictionary (ECKit)

- (void)eckit_safeSetObject:(id)obj forKey:(id)key
{
    if (obj != nil && key != nil) {
        [self setObject:obj forKey:key];
    }
}

@end
