//
//  UIView+ECKit.m
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

#import "UIView+ECKit.h"


@implementation UIView (ECKit)

- (UIImage *)eckit_imageFromView
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollSelf = (UIScrollView *)self;
        CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0.0f, -scrollSelf.contentOffset.y);
    }
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *anImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return anImage;
}

#if DEBUG
- (id)eckit_debugQuickLookObject
{
    if (CGRectGetWidth(self.bounds) < 0.0f || CGRectGetWidth(self.bounds) < 0.0f) {
        return nil;
    }

    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, self.window.screen.scale);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}
#endif

@end
