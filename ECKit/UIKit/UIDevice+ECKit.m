//
//  UIDevice+ECKit.m
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

#import "UIDevice+ECKit.h"

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>


@implementation UIDevice (ECKit)

+ (NSComparisonResult)ec_compareToVersion:(NSString *)version
{
    return [[[self currentDevice] systemVersion] compare:version options:NSNumericSearch];
}

+ (BOOL)ec_systemVersionIsEqual:(NSString *)version
{
    return [self ec_compareToVersion:version] == NSOrderedSame;
}

+ (BOOL)ec_systemVersionIsGreaterThan:(NSString *)version
{
    return [self ec_compareToVersion:version] == NSOrderedDescending;
}

+ (BOOL)ec_systemVersionIsGreaterThanOrEqual:(NSString *)version
{
    return [self ec_compareToVersion:version] != NSOrderedAscending;
}

+ (BOOL)ec_systemVersionIsLessThan:(NSString *)version
{
    return [self ec_compareToVersion:version] == NSOrderedAscending;
}

+ (BOOL)ec_systemVersionIsLessThanOrEqual:(NSString *)version
{
    return [self ec_compareToVersion:version] != NSOrderedDescending;
}


//------------------------------------------------------------------------------
#pragma mark -
#pragma mark Device Family

- (UIDeviceFamily)ec_deviceFamily
{
    switch ([self ec_platform]) {
        case UIDeviceiPad1:
        case UIDeviceiPad2:
        case UIDeviceiPad4G:
        case UIDeviceiPad3:
        case UIDeviceiPadAir:
        case UIDeviceiPadMini:
        case UIDeviceiPadMiniRetina:
        case UIDeviceiPadSimulator:
        case UIDeviceUnknowniPad:
            return UIDeviceFamilyiPad;
        case UIDeviceiPhone1:
        case UIDeviceiPhone3G:
        case UIDeviceiPhone3GS:
        case UIDeviceiPhone4:
        case UIDeviceiPhone4S:
        case UIDeviceiPhone5:
        case UIDeviceiPhoneSimulator:
        case UIDeviceUnknowniPhone:
            return UIDeviceFamilyiPhone;
        case UIDeviceiPod1:
        case UIDeviceiPod2:
        case UIDeviceiPod3:
        case UIDeviceiPod4:
        case UIDeviceiPod5:
        case UIDeviceUnknowniPod:
            return UIDeviceFamilyiPod;
        case UIDeviceUnknown:
        default:
            return UIDeviceFamilyUnknown;
    }
}

- (BOOL)ec_isIPadDeviceFamily
{
    return [self ec_deviceFamily] == UIDeviceFamilyiPad;
}

- (BOOL)ec_isIPhoneDeviceFamily
{
    return [self ec_deviceFamily] == UIDeviceFamilyiPhone;
}

- (BOOL)ec_isIPodDeviceFamily
{
    return [self ec_deviceFamily] == UIDeviceFamilyiPod;
}

- (BOOL)ec_isSimulatorDeviceFamily
{
    switch ([self ec_platform]) {
        case UIDeviceiPadSimulator:
        case UIDeviceiPhoneSimulator:
            return YES;
        default:
            return NO;
    }
}

//------------------------------------------------------------------------------
#pragma mark -
#pragma mark Platform

- (UIDevicePlatform)ec_platform
{
    static UIDevicePlatform p = UIDeviceUnknown;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        p = [self ec_internalPlatform];
    });
    return p;
}

- (NSString *)ec_platformName
{
    switch ([self ec_platform]) {
        case UIDeviceUnknowniPhone:
            return @"Unknown iPhone";
        case UIDeviceUnknowniPod:
            return @"Unknown iPod";
        case UIDeviceUnknowniPad:
            return @"Unknown iPad";
        case UIDeviceiPhoneSimulator:
            return @"iPhone Simulator";
        case UIDeviceiPadSimulator:
            return @"iPad Simulator";
        case UIDeviceiPhone1:
            return @"iPhone 1";
        case UIDeviceiPhone3G:
            return @"iPhone 3G";
        case UIDeviceiPhone3GS:
            return @"iPhone 3GS";
        case UIDeviceiPhone4:
            return @"iPhone 4";
        case UIDeviceiPhone4S:
            return @"iPhone 4S";
        case UIDeviceiPhone5:
            return @"iPhone 5";
        case UIDeviceiPod1:
            return @"iPod 1";
        case UIDeviceiPod2:
            return @"iPod 2";
        case UIDeviceiPod3:
            return @"iPod 3";
        case UIDeviceiPod4:
            return @"iPod 4";
        case UIDeviceiPod5:
            return @"iPod 5";
        case UIDeviceiPad1:
            return @"iPad 1";
        case UIDeviceiPad2:
            return @"iPad 2";
        case UIDeviceiPad3:
            return @"iPad 3";
        case UIDeviceiPad4G:
            return @"iPad 4G";
        case UIDeviceiPadAir:
            return @"iPad Air";
        case UIDeviceiPadMini:
            return @"iPad Mini";
        case UIDeviceiPadMiniRetina:
            return @"iPad Mini Retina";
        case UIDeviceUnknown:
        default:
            return @"Unknown iOS device";
    }
}


//------------------------------------------------------------------------------
#pragma mark -
#pragma mark Misc

- (BOOL)ec_isIPad1
{
    static BOOL isIPad1;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isIPad1 = [self ec_platform] == UIDeviceiPad1;
    });

    return isIPad1;
}


//------------------------------------------------------------------------------
#pragma mark -
#pragma mark Private Helpers

/**
 * Find the platform string here: http://www.everymac.com/systems/apple/ipad/index-ipad-specs.html
 *
 * @return UIDevicePlatform the platform this device represents.
 */
- (UIDevicePlatform)ec_internalPlatform
{
    NSString *platformString = [self ec_getSysInfoByName:"hw.machine"];

    // iPhone
    if ([platformString isEqualToString:@"iPhone1,1"]) {
        return UIDeviceiPhone1;
    }
    if ([platformString isEqualToString:@"iPhone1,2"]) {
        return UIDeviceiPhone3G;
    }
    if ([platformString hasPrefix:@"iPhone2"]) {
        return UIDeviceiPhone3GS;
    }
    if ([platformString hasPrefix:@"iPhone3"]) {
        return UIDeviceiPhone4;
    }
    if ([platformString hasPrefix:@"iPhone4"]) {
        return UIDeviceiPhone4S;
    }
    if ([platformString hasPrefix:@"iPhone5"]) {
        return UIDeviceiPhone5;
    }

    // iPod
    if ([platformString hasPrefix:@"iPod1"]) {
        return UIDeviceiPod1;
    }
    if ([platformString isEqualToString:@"iPod2,2"]) {
        return UIDeviceiPod3;
    }
    if ([platformString hasPrefix:@"iPod2"]) {
        return UIDeviceiPod2;
    }
    if ([platformString hasPrefix:@"iPod3"]) {
        return UIDeviceiPod3;
    }
    if ([platformString hasPrefix:@"iPod4"]) {
        return UIDeviceiPod4;
    }
    if ([platformString hasPrefix:@"iPod5"]) {
        return UIDeviceiPod5;
    }

    // iPad
    if ([platformString hasPrefix:@"iPad1"]) {
        return UIDeviceiPad1;
    }
    if ([platformString hasPrefix:@"iPad2"]) {
        NSInteger submodel = [self ec_getSubmodel:platformString];
        if (submodel <= 4) {
            return UIDeviceiPad2;
        } else {
            return UIDeviceiPadMini;
        }
    }
    if ([platformString hasPrefix:@"iPad3"]) {
        NSInteger submodel = [self ec_getSubmodel:platformString];
        if (submodel <= 3) {
            return UIDeviceiPad3;
        } else {
            return UIDeviceiPad4G;
        }
    }

    if ([platformString hasPrefix:@"iPad4"]) {
        NSInteger submodel = [self ec_getSubmodel:platformString];
        if (submodel < 4) {
            return UIDeviceiPadAir;
        } else {
            return UIDeviceiPadMiniRetina;
        }
    }

    // Unknown device
    if ([platformString hasPrefix:@"iPhone"]) {
        return UIDeviceUnknowniPhone;
    }
    if ([platformString hasPrefix:@"iPod"]) {
        return UIDeviceUnknowniPod;
    }
    if ([platformString hasPrefix:@"iPad"]) {
        return UIDeviceUnknowniPad;
    }

    // Simulator
    if ([platformString hasSuffix:@"86"] || [platformString isEqual:@"x86_64"]) {
        BOOL smallerScreen = CGRectGetWidth([UIScreen mainScreen].bounds) < 768;
        return smallerScreen ? UIDeviceiPhoneSimulator : UIDeviceiPadSimulator;
    }

    return UIDeviceUnknown;
}

- (NSString *)ec_getSysInfoByName:(char *)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);

    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);

    NSString *results = @(answer);

    free(answer);

    return results;
}

- (NSInteger)ec_getSubmodel:(NSString *)platform
{
    NSInteger submodel = -1;

    NSArray *components = [platform componentsSeparatedByString:@","];
    if (components.count >= 2) {
        submodel = [[components objectAtIndex:1] integerValue];
    }
    return submodel;
}

@end
