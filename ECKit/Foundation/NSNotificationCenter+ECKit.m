//
//  NSNotificationCenter+ECKit.m
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

#import "NSNotificationCenter+ECKit.h"

@implementation NSNotificationCenter (ECKit)

- (void)eckit_postNotificationNameOnMainThread:(NSString *)notificationName object:(id)obj userInfo:(NSDictionary *)userInfo
{
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self postNotificationName:notificationName object:obj userInfo:userInfo];
        });
    } else {
        [self postNotificationName:notificationName object:obj userInfo:userInfo];
    }
}

@end
