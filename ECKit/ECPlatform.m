//
//  ECPlatform.m
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

#import "ECPlatform.h"


NSURL *ECDocumentsURL() {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *directories = [manager URLsForDirectory:NSDocumentDirectory
                                           inDomains:NSUserDomainMask];
    NSURL *url = [directories lastObject];
    return url;
}

NSString *ECDocumentsPath() {
    return [ECDocumentsURL() path];
}

NSURL *ECLibraryURL() {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *directories = [manager URLsForDirectory:NSLibraryDirectory
                                           inDomains:NSUserDomainMask];
    NSURL *url = [directories lastObject];
    return url;
}

NSString *ECLibraryPath() {
    return [ECLibraryURL() path];
}

NSURL *ECCachesURL() {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *directories = [manager URLsForDirectory:NSCachesDirectory
                                           inDomains:NSUserDomainMask];
    NSURL *url = [directories lastObject];
    return url;
}

NSString *ECCachesPath() {
    return [ECCachesURL() path];
}

NSString *ECBundlePath() {
    return [[NSBundle mainBundle] bundlePath];
}
