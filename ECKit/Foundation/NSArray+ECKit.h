//
//  NSArray+ECKit.h
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

@import Foundation;

@interface NSArray (ECKit)

- (NSArray *)ec_mapObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block;

@end
