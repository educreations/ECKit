//
//  UIImage+ECKit.h
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

@import UIKit;


@interface UIImage (ECKit)

- (void)ec_decompressImage;

- (UIImage *)ec_imageCroppedToRect:(CGRect)croppedRect;

- (UIImage *)ec_imageScaledToNonRetina;

@end
