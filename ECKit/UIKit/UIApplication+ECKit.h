//
//  UIApplication+ECKit.h
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

@import UIKit;


@interface UIApplication (ECKit)

+ (NSString *)eckit_displayName;
+ (NSString *)eckit_version;
+ (NSString *)eckit_buildVersion;

@end
