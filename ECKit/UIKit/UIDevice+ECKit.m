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
        case UIDeviceiPadAir2:
        case UIDeviceiPadMini:
        case UIDeviceiPadMiniRetina:
        case UIDeviceiPadMini3:
        case UIDeviceiPadSimulator:
        case UIDeviceiPadMini4:
        case UIDeviceiPadMini5:
        case UIDeviceiPadPro12inch:
        case UIDeviceiPadPro9inch:
        case UIDeviceUnknowniPad:
            return UIDeviceFamilyiPad;
        case UIDeviceiPhone1:
        case UIDeviceiPhone3G:
        case UIDeviceiPhone3GS:
        case UIDeviceiPhone4:
        case UIDeviceiPhone4S:
        case UIDeviceiPhone5:
        case UIDeviceiPhone5c:
        case UIDeviceiPhone5s:
        case UIDeviceiPhone6:
        case UIDeviceiPhone6s:
        case UIDeviceiPhone6Plus:
        case UIDeviceiPhone6sPlus:
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
        case UIDeviceiPhoneSimulator:
            return @"iPhone Simulator";
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
        case UIDeviceiPhone5c:
            return @"iPhone 5c";
        case UIDeviceiPhone5s:
            return @"iPhone 5s";
        case UIDeviceiPhone6:
            return @"iPhone 6";
        case UIDeviceiPhone6s:
            return @"iPhone 6s";
        case UIDeviceiPhone6Plus:
            return @"iPhone 6 Plus";
        case UIDeviceiPhone6sPlus:
            return @"iPhone 6s Plus";
        case UIDeviceiPhoneSE:
            return @"iPhone SE";
        case UIDeviceUnknowniPhone:
            return @"Unknown iPhone";

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
        case UIDeviceUnknowniPod:
            return @"Unknown iPod";

        case UIDeviceiPadSimulator:
            return @"iPad Simulator";
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
        case UIDeviceiPadAir2:
            return @"iPad Air 2";
        case UIDeviceiPadMini:
            return @"iPad Mini";
        case UIDeviceiPadMiniRetina:
            return @"iPad Mini Retina";
        case UIDeviceiPadMini3:
            return @"iPad Mini 3";
        case UIDeviceiPadMini4:
            return @"iPad Mini 4";
        case UIDeviceiPadMini5:
            return @"iPad Mini 5";
        case UIDeviceiPadPro12inch:
            return @"iPad Pro 12 inch";
        case UIDeviceiPadPro9inch:
            return @"iPad Pro 9 inch";
        case UIDeviceiPad5:
            return @"iPad 5";
        case UIDeviceiPadPro12inch2:
            return @"iPad Pro 12 inch 2";
        case UIDeviceiPadPro10inch:
            return @"iPad Pro 10.5 inch";
        case UIDeviceiPad6:
            return @"iPad 6";
        case UIDeviceiPadPro11inch:
            return @"iPad Pro 11 inch";
        case UIDeviceiPadPro12inch3:
            return @"iPad Pro 12 inch 3";
        case UIDeviceiPadAir3:
            return @"iPad Air 3";

        case UIDeviceUnknowniPad:
            return @"Unknown iPad";

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
 * Find the platform string here: http://theiphonewiki.com/wiki/Models
 *
 * @return UIDevicePlatform the platform this device represents.
 */
- (UIDevicePlatform)ec_internalPlatform
{
#if !(TARGET_IPHONE_SIMULATOR)
    NSString *platformString = [self ec_getSysInfoByName:"hw.machine"];
#else
    NSString *platformString = [[[NSProcessInfo processInfo] environment] objectForKey:@"SIMULATOR_MODEL_IDENTIFIER"] ?: @"";
#endif

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
        NSInteger submodel = [self ec_getSubmodel:platformString];
        if (submodel <= 2) {
            return UIDeviceiPhone5;
        } else {
            return UIDeviceiPhone5c;
        }
    }
    if ([platformString hasPrefix:@"iPhone6"]) {
        return UIDeviceiPhone5s;
    }
    if ([platformString hasPrefix:@"iPhone7"]) {
        NSInteger submodel = [self ec_getSubmodel:platformString];
        if (submodel <= 1) {
            return UIDeviceiPhone6Plus;
        } else {
            return UIDeviceiPhone6;
        }
    }
    if ([platformString hasPrefix:@"iPhone8"]) {
        NSInteger submodel = [self ec_getSubmodel:platformString];
        if (submodel <= 1) {
            return UIDeviceiPhone6s;
        } else if (submodel < 4) {
            return UIDeviceiPhone6sPlus;
        } else {
            return UIDeviceiPhoneSE;
        }
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
        } else if (submodel < 7) {
            return UIDeviceiPadMiniRetina;
        } else {
            return UIDeviceiPadMini3;
        }
    }

    if ([platformString hasPrefix:@"iPad5"]) {
        NSInteger submodel = [self ec_getSubmodel:platformString];
        if (submodel < 3) {
            return UIDeviceiPadMini4;
        } else {
            return UIDeviceiPadAir2;
        }
    }

    if ([platformString hasPrefix:@"iPad6"]) {
        NSInteger submodel = [self ec_getSubmodel:platformString];
        switch (submodel) {
            case 3:
            case 4:
                return UIDeviceiPadPro9inch;
            case 7:
            case 8:
                return UIDeviceiPadPro12inch;
            case 11:
            case 12:
                return UIDeviceiPad5;
            default:
                break;
        }
    }

    if ([platformString hasPrefix:@"iPad7"]) {
        NSInteger submodel = [self ec_getSubmodel:platformString];
        switch (submodel) {
            case 1:
            case 2:
                return UIDeviceiPadPro12inch2;
            case 3:
            case 4:
                return UIDeviceiPadPro10inch;
            case 5:
            case 6:
                return UIDeviceiPad6;
            default:
                break;
        }
    }

    if ([platformString hasPrefix:@"iPad8"]) {
        NSInteger submodel = [self ec_getSubmodel:platformString];
        switch (submodel) {
            case 1:
            case 2:
            case 3:
            case 4:
                return UIDeviceiPadPro11inch;
            case 5:
            case 6:
            case 7:
            case 8:
                return UIDeviceiPadPro12inch3;
            default:
                break;
        }
    }

    if ([platformString hasPrefix:@"iPad11"]) {
        NSInteger submodel = [self ec_getSubmodel:platformString];
        switch (submodel) {
            case 1:
            case 2:
                return UIDeviceiPadMini5;
            case 3:
            case 4:
                return UIDeviceiPadAir3;
            default:
                break;
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
