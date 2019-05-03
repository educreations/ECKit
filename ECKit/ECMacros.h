//
//  ECMacros.h
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//


//------------------------------------------------------------------------------
#pragma mark -
#pragma mark Future Conventions

#ifndef NS_DESIGNATED_INITIALIZER
# if __has_attribute(objc_designated_initializer)
#  define NS_DESIGNATED_INITIALIZER __attribute((objc_designated_initializer))
# else
#  define NS_DESIGNATED_INITIALIZER
# endif
#endif

#ifndef NS_REQUIRES_SUPER
# if __has_attribute(objc_requires_super)
#  define NS_REQUIRES_SUPER __attribute((objc_requires_super))
# else
#  define NS_REQUIRES_SUPER
# endif
#endif


//------------------------------------------------------------------------------
#pragma mark -
#pragma mark Assertions

#ifndef ECAssert
#if DEBUG
# define ECAssert( ... )                            NSAssert(__VA_ARGS__)
#else
# define ECAssert(condition, desc, ...) \
    do { \
        __PRAGMA_PUSH_NO_EXTRA_ARG_WARNINGS \
        if (!(condition)) { \
            NSLog(@"[FAILED ASSERTION] %@", (desc), ##__VA_ARGS__); \
        } \
        __PRAGMA_POP_NO_EXTRA_ARG_WARNINGS \
    } while(0)
#endif
#endif

#ifndef ECParameterAssert
# define ECParameterAssert(condition)               ECAssert((condition), @"Invalid parameter not satisfying: %s", #condition)
#endif

#ifndef ECAssertMainThread
# define ECAssertMainThread()                       ECAssert([NSThread isMainThread], @"Not running on the main thread!")
#endif
#ifndef ECAssertNotMainThread
# define ECAssertNotMainThread()                    ECAssert(![NSThread isMainThread], @"Running on the main thread!")
#endif
