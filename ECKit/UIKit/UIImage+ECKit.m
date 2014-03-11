//
//  UIImage+ECKit.m
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

#import "UIImage+ECKit.h"


@implementation UIImage (ECKit)

- (void)ec_decompressImage
{
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    [self drawAtPoint:CGPointZero];
    UIGraphicsEndImageContext();
}

- (UIImage *)ec_imageCroppedToRect:(CGRect)croppedRect
{
    CGRect adjustedRect = CGRectMake(roundf(CGRectGetMinX(croppedRect) * self.scale),
                                     roundf(CGRectGetMinY(croppedRect) * self.scale),
                                     roundf(CGRectGetWidth(croppedRect) * self.scale),
                                     roundf(CGRectGetHeight(croppedRect) * self.scale));

    switch (self.imageOrientation) {
        case UIImageOrientationDown:
            adjustedRect = CGRectMake(CGRectGetMinX(adjustedRect),
                                      self.size.height * self.scale - CGRectGetMinY(adjustedRect) - CGRectGetHeight(adjustedRect),
                                      CGRectGetWidth(adjustedRect),
                                      CGRectGetHeight(adjustedRect));
            break;
        case UIImageOrientationDownMirrored:
            adjustedRect = CGRectMake(self.size.width * self.scale - CGRectGetMinX(adjustedRect) - CGRectGetWidth(adjustedRect),
                                      self.size.height * self.scale - CGRectGetMinY(adjustedRect) - CGRectGetHeight(adjustedRect),
                                      CGRectGetWidth(adjustedRect),
                                      CGRectGetHeight(adjustedRect));
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
        case UIImageOrientationUpMirrored:
            if (CGRectGetMinX(adjustedRect) > 0.0 || CGRectGetMinY(adjustedRect) > 0.0) {
                NSLog(@"We don't support non-zero origins for these orientations!");
            }
            break;
        case UIImageOrientationUp:
            break;
    }

    CGImageRef croppedRef = CGImageCreateWithImageInRect(self.CGImage, adjustedRect);
    UIImage *croppedImage = [UIImage imageWithCGImage:croppedRef
                                                scale:self.scale
                                          orientation:self.imageOrientation];
    CGImageRelease(croppedRef);

    return croppedImage;
}

- (UIImage *)ec_imageScaledToNonRetina
{
    if (self.scale == 1.0) {
        return self;
    }

    UIGraphicsBeginImageContextWithOptions(self.size, NO, 1.0);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
