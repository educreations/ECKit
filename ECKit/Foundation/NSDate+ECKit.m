//
//  NSDate+ECKit.m
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

#import "NSDate+ECKit.h"

@implementation NSDate (ECKit)

+ (NSDate *)ec_dateFromRFC1123:(NSString *)value
{
    if (!value) {
        return nil;
    }

    // Try the RFC1123 Date format
    static NSDateFormatter *rfc1123 = nil;
    if (rfc1123 == nil) {
        rfc1123 = [[NSDateFormatter alloc] init];
        rfc1123.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
        rfc1123.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        rfc1123.dateFormat = @"EEE',' dd MMM yyyy HH':'mm':'ss z";
    }
    NSDate *ret = [rfc1123 dateFromString:value];
    if(ret != nil) {
        return ret;
    }

    // 1123 didn't do it, so try the RFC850 format
    static NSDateFormatter *rfc850 = nil;
    if (rfc850 == nil) {
        rfc850 = [[NSDateFormatter alloc] init];
        rfc850.locale = rfc1123.locale;
        rfc850.timeZone = rfc1123.timeZone;
        rfc850.dateFormat = @"EEEE',' dd'-'MMM'-'yy HH':'mm':'ss z";
    }
    ret = [rfc850 dateFromString:value];
    if (ret != nil) {
        return ret;
    }

    // Finally, try the last date format allowed in the spec, C's asctime
    static NSDateFormatter *asctime = nil;
    if (asctime == nil) {
        asctime = [[NSDateFormatter alloc] init];
        asctime.locale = rfc1123.locale;
        asctime.timeZone = rfc1123.timeZone;
        asctime.dateFormat = @"EEE MMM d HH':'mm':'ss yyyy";
    }

    return [asctime dateFromString:value];
}

- (NSString*)ec_rfc1123String
{
    static NSDateFormatter *df = nil;
    if (df == nil) {
        df = [[NSDateFormatter alloc] init];
        df.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
        df.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        df.dateFormat = @"EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'";
    }

    return [df stringFromDate:self];
}

@end
