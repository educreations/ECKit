//
//  UIDevice+ECKit.h
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSUInteger, UIDeviceFamily) {
    UIDeviceFamilyUnknown,

    UIDeviceFamilyiPhone,
    UIDeviceFamilyiPad,
    UIDeviceFamilyiPod,
};

typedef NS_ENUM(NSUInteger, UIDevicePlatform) {
    UIDeviceUnknown,
    UIDeviceUnknowniPhone,
    UIDeviceUnknowniPod,
    UIDeviceUnknowniPad,

    UIDeviceiPhoneSimulator,
    UIDeviceiPadSimulator,

    UIDeviceiPhone1,
    UIDeviceiPhone3G,
    UIDeviceiPhone3GS,
    UIDeviceiPhone4,
    UIDeviceiPhone4S,
    UIDeviceiPhone5,
    UIDeviceiPhone5c,
    UIDeviceiPhone5s,
    UIDeviceiPhone6,
    UIDeviceiPhone6s,
    UIDeviceiPhone6Plus,
    UIDeviceiPhone6sPlus,

    UIDeviceiPod1,
    UIDeviceiPod2,
    UIDeviceiPod3,
    UIDeviceiPod4,
    UIDeviceiPod5,

    UIDeviceiPad1,
    UIDeviceiPad2,
    UIDeviceiPad3,
    UIDeviceiPad4G,
    UIDeviceiPadAir,
    UIDeviceiPadAir2,
    UIDeviceiPadMini,
    UIDeviceiPadMiniRetina,
    UIDeviceiPadMini3,
    UIDeviceiPadMini4,
    UIDeviceiPadPro,
};


@interface UIDevice (ECKit)

+ (BOOL)ec_systemVersionIsEqual:(NSString *)version;
+ (BOOL)ec_systemVersionIsGreaterThan:(NSString *)version;
+ (BOOL)ec_systemVersionIsGreaterThanOrEqual:(NSString *)version;
+ (BOOL)ec_systemVersionIsLessThan:(NSString *)version;
+ (BOOL)ec_systemVersionIsLessThanOrEqual:(NSString *)version;

- (UIDeviceFamily)ec_deviceFamily;
- (BOOL)ec_isIPadDeviceFamily;
- (BOOL)ec_isIPhoneDeviceFamily;
- (BOOL)ec_isIPodDeviceFamily;
- (BOOL)ec_isSimulatorDeviceFamily;

- (UIDevicePlatform)ec_platform;
- (NSString *)ec_platformName;

- (BOOL)ec_isIPad1;

@end
