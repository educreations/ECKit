//
//  NSArray+ECKit.m
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

#import "NSArray+ECKit.h"

@implementation NSArray (ECKit)

- (NSArray *)ec_mapObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block
{
    if (!block) {
        return [NSArray arrayWithArray:self];
    }

    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];

    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [result addObject:block(obj, idx)];
    }];

    return result;
}

@end
