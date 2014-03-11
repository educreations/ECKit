//
//  UIScreen+ECKit.m
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

#import "UIScreen+ECKit.h"


@implementation UIScreen (ECKit)

- (BOOL)ec_isRetina
{
    return (self.scale == 2.0);
}

- (BOOL)ec_isWidescreen
{
    return (fabs((double)CGRectGetHeight(self.bounds) - (double )568) < DBL_EPSILON);
}

@end
