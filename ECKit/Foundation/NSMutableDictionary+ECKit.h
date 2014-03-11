//
//  NSMutableDictionary+ECKit.h
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

@import Foundation;

@interface NSMutableDictionary (ECKit)

- (void)ec_safeSetObject:(id)obj forKey:(id)key;

@end
