//
//  NSMutableArray+ECKit.m
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

#import "NSMutableArray+ECKit.h"

@implementation NSMutableArray (ECKit)

- (void)eckit_safeAddObject:(id)obj
{
    if (obj != nil) {
        [self addObject:obj];
    }
}

@end
