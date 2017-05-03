//
//  TOStatusBarSimulator.h
//
//  Copyright 2017 Timothy Oliver. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
//  IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <Foundation/Foundation.h>

@class UIView;

@interface TOStatusBarSimulator : NSObject

/* Replaces the system status bar with a simulated one */
+ (void)show;

/* Clears the simulated status bar and restores the proper one. */
+ (void)hide;

/* Default is hidden on iPhone, "iPad" on iPad, and "iPod" on iPod touch. */
+ (void)setCarrierString:(NSString *)carrierString;

/* Shows the actual system time. When false, the clock only always displays '9:41 AM'. */
+ (void)showActualTime:(BOOL)actualTime;

/* Signal strength is normally only shown on iPhone, but can be shown on others. */
+ (void)alwaysShowSignalStrength:(BOOL)showSignalStrength;

@end
