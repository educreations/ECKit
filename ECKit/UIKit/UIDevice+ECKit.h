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
    UIDeviceiPhoneSE,

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
    UIDeviceiPadMini5,
    UIDeviceiPadPro12inch,
    UIDeviceiPadPro9inch,
    UIDeviceiPad5,
    UIDeviceiPadPro12inch2,
    UIDeviceiPadPro10inch,
    UIDeviceiPad6,
    UIDeviceiPadPro11inch,
    UIDeviceiPadPro12inch3,
    UIDeviceiPadAir3,
};


@interface UIDevice (ECKit)

+ (BOOL)eckit_systemVersionIsEqual:(NSString *)version;
+ (BOOL)eckit_systemVersionIsGreaterThan:(NSString *)version;
+ (BOOL)eckit_systemVersionIsGreaterThanOrEqual:(NSString *)version;
+ (BOOL)eckit_systemVersionIsLessThan:(NSString *)version;
+ (BOOL)eckit_systemVersionIsLessThanOrEqual:(NSString *)version;

- (UIDeviceFamily)eckit_deviceFamily;
- (BOOL)eckit_isIPadDeviceFamily;
- (BOOL)eckit_isIPhoneDeviceFamily;
- (BOOL)eckit_isIPodDeviceFamily;
- (BOOL)eckit_isSimulatorDeviceFamily;

- (UIDevicePlatform)eckit_platform;
- (NSString *)eckit_platformName;

- (BOOL)eckit_isIPad1;

@end
