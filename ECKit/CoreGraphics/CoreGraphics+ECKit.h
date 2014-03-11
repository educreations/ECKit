//
//  CoreGraphics+ECKit.m
//  ECKit
//
//  Created by Chris Streeter on 3/11/14.
//  Copyright (c) 2014 Educreations, Inc. All rights reserved.
//

@import CoreGraphics;

//------------------------------------------------------------------------------
#pragma mark -
#pragma mark Misc Helpers

CG_INLINE CGFloat CGSquared(CGFloat x)
{
    return x * x;
}


//------------------------------------------------------------------------------
#pragma mark -
#pragma mark CGPoints

CG_INLINE CGPoint CGPointMid(CGPoint a, CGPoint b)
{
    return (CGPoint){
        .x = (a.x + b.x) / 2.0,
        .y = (a.y + b.y) / 2.0,
    };
}

CG_INLINE BOOL CGPointEqualToPointWithin(CGPoint point1, CGPoint point2, CGFloat tolerance)
{
    return (ABS(point1.x - point2.x) <= tolerance) && (ABS(point1.y - point2.y) <= tolerance);
}


//------------------------------------------------------------------------------
#pragma mark -
#pragma mark CGRects

CG_INLINE CGRect CGRectRound(CGRect original)
{
    return (CGRect){
        .origin.x = roundf(CGRectGetMinX(original)),
        .origin.y = roundf(CGRectGetMinY(original)),
        .size.width = roundf(CGRectGetWidth(original)),
        .size.height = roundf(CGRectGetHeight(original)),
    };
}


//------------------------------------------------------------------------------
#pragma mark -
#pragma mark Line Lengths

CG_INLINE CGFloat CGLineLengthSquared(CGPoint start, CGPoint end)
{
    return CGSquared(end.x - start.x) + CGSquared(end.y - start.y);
}

CG_INLINE CGFloat CGLineLength(CGPoint start, CGPoint end)
{
    return sqrtf(CGLineLengthSquared(start, end));
}


//------------------------------------------------------------------------------
#pragma mark -
#pragma mark Circular Geometry

CG_INLINE CGFloat CGRadiansToDegrees(CGFloat radians)
{
    return radians * (180.0 / M_PI);
}

CG_INLINE CGFloat CGDegreesToRadians(CGFloat degrees)
{
    return degrees * (M_PI / 180.0);
}


//------------------------------------------------------------------------------
#pragma mark -
#pragma mark Bezier Points

typedef CGPoint CGBezierPoint;

CG_INLINE CGBezierPoint _CGMakeBezierPointHelper(CGPoint a, CGPoint b, CGFloat t)
{
    return (CGBezierPoint){
        .x = a.x + (b.x - a.x) * t,
        .y = a.y + (b.y - a.y) * t,
    };
}

CG_INLINE CGBezierPoint CGMakeBezierPoint(CGPoint p1, CGPoint p2, CGPoint control, CGFloat t)
{
    return _CGMakeBezierPointHelper(_CGMakeBezierPointHelper(p1, control, t),
                                    _CGMakeBezierPointHelper(control, p2, t),
                                    t);
}

/*
 * Approximate the bezier curve length, falling back to straight-line
 * length if the algorithm fails. Algorithm taken from:
 * http://segfaultlabs.com/docs/quadratic-bezier-curve-length
 */
CG_INLINE CGFloat CGBezierCurveLength(CGPoint start, CGPoint control, CGPoint end)
{
    CGPoint a, b;
    a.x = start.x - 2.0 * control.x + end.x;
    a.y = start.y - 2.0 * control.y + end.y;
    b.x = 2.0 * control.x - 2.0 * start.x;
    b.y = 2.0 * control.y - 2.0 * start.y;

    CGFloat A = 4.0 * (CGSquared(a.x) + CGSquared(a.y));
    CGFloat B = 4.0 * (a.x * b.x + a.y * b.y);
    CGFloat C = CGSquared(b.x) + CGSquared(b.y);

    CGFloat abc = 2.0 * sqrtf(A + B + C);
    CGFloat a2 = sqrtf(A);
    CGFloat a32 = 2.0 * A * a2;
    CGFloat c2 = 2.0 * sqrtf(C);
    CGFloat ba = B / a2;

    CGFloat tmp = ((a32 * abc)
                   + (a2 * B * (abc - c2))
                   + ((4.0 * C * A - CGSquared(B))
                      * logf( (2.0 * a2 + ba + abc) / (ba + c2) ))
                   ) / (4.0 * a32);
    if (isnan(tmp) || isinf(tmp)) {
        // The approximation didn't work, so compute the straight line length
        return CGLineLength(start, end);
    } else {
        return tmp;
    }
}
