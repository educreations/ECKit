//
//  NSNotificationCenter+ECKit.h
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

@import Foundation;

@interface NSNotificationCenter (ECKit)

- (void)eckit_postNotificationNameOnMainThread:(NSString *)notificationName object:(id)obj userInfo:(NSDictionary *)userInfo;

@end
