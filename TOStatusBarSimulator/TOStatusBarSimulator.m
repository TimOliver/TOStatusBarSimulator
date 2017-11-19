//
//  TOStatusBarSimulator.m
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

#import "TOStatusBarSimulator.h"
#import "TOStatusBarView.h"
#import "TOModernStatusBarView.h"
#import "TOStatusBarProxy.h"
#import "TOStatusBarTimer.h"
#import <UIKit/UIKit.h>

static UIView *_systemStatusBar = nil;
static TOStatusBarView *_statusBar = nil;
static TOModernStatusBarView *_modernStatusBar = nil;
static TOStatusBarProxy *_statusBarProxy = nil;
static TOStatusBarTimer *_statusBarTimer = nil;
static NSString *_carrierString = nil;
static BOOL _alwaysShowSignalStrength = NO;
static BOOL _showActualTime = NO;

@implementation TOStatusBarSimulator

+ (void)show
{
    if (_systemStatusBar) { return; }

    BOOL modern;
    _systemStatusBar = [[self class] systemStatusBarModern:&modern];

    [_systemStatusBar removeFromSuperview];

    UIWindow *statusBarWindow = [[self class] statusBarWindow];

    UIStatusBarStyle style = [[UIApplication sharedApplication] statusBarStyle];
    UIColor *tintColor = style == UIStatusBarStyleLightContent ? [UIColor whiteColor] : [UIColor blackColor];

    if (!modern) {
        _statusBar = [[TOStatusBarView alloc] initWithFrame:(CGRect){0, 0, statusBarWindow.frame.size.width, 20.0f}];
        _statusBar.carrierString = _carrierString ?: [[self class] defaultCarrierString];
        _statusBar.showSignalStrength = (_alwaysShowSignalStrength || [[self class] signalStrengthVisibleByDefault]);
        _statusBar.tintColor = tintColor;
        _statusBar.alpha = _systemStatusBar.alpha;
        [statusBarWindow addSubview:_statusBar];

        _statusBarProxy = [[TOStatusBarProxy alloc] initWithSystemStatusBar:_systemStatusBar simulatedStatusBar:_statusBar];
    }
    else {
        _modernStatusBar = [[TOModernStatusBarView alloc] initWithFrame:(CGRect){0, 0, statusBarWindow.frame.size.width, 44.0f}];
        _modernStatusBar.tintColor = tintColor;
        _modernStatusBar.alpha = _systemStatusBar.alpha;
        [statusBarWindow addSubview:_modernStatusBar];

        _statusBarProxy = [[TOStatusBarProxy alloc] initWithSystemStatusBar:_systemStatusBar simulatedStatusBar:_modernStatusBar];
    }

    [[self class] startTimerForClock:_showActualTime];
}

+ (void)hide
{
    _statusBarProxy = nil;

    [_statusBar removeFromSuperview];
    _statusBar = nil;

    UIWindow *statusBarWindow = [[self class] statusBarWindow];
    [statusBarWindow addSubview:_systemStatusBar];
    _systemStatusBar = nil;
}

#pragma mark - Public Configuration -

+ (void)alwaysShowSignalStrength:(BOOL)showSignalStrength
{
    _alwaysShowSignalStrength = showSignalStrength;
    _statusBar.showSignalStrength = (_alwaysShowSignalStrength || [[self class] signalStrengthVisibleByDefault]);
}

+ (void)setCarrierString:(NSString *)carrierString
{
    _carrierString = carrierString;
    _statusBar.carrierString = carrierString ?: [[self class] defaultCarrierString];
}

+ (void)showActualTime:(BOOL)actualTime
{
    if (actualTime == _showActualTime) { return; }
    _showActualTime = actualTime;
    [[self class] startTimerForClock:actualTime];
}

#pragma mark - Time Handling -
+ (void)startTimerForClock:(BOOL)start
{
    if (_statusBar == nil && _modernStatusBar == nil) {
        return;
    }

    if (start) {
        _statusBarTimer = [[TOStatusBarTimer alloc] init];
        _statusBarTimer.hideAMPM = (_modernStatusBar != nil);
        _statusBarTimer.timeChangedHandler = ^(NSString *newTime) {
            _statusBar.timeString = newTime;
            _modernStatusBar.timeString = newTime;
        };
        [_statusBarTimer start];
    }
    else {
        [_statusBarTimer stop];
        _statusBar.timeString = nil;
        _modernStatusBar.timeString = nil;
        _statusBarTimer = nil;
    }
}

#pragma mark - Default States -

+ (NSString *)defaultCarrierString
{
    // iPad
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return @"iPad";
    }

    // iPod touch
    if ([[[UIDevice currentDevice] model] rangeOfString:@"iPod"].location != NSNotFound) {
        return @"iPod";
    }

    // Nothing for iPhone
    return nil;
}

+ (BOOL)signalStrengthVisibleByDefault
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return NO;
    }

    if ([[[UIDevice currentDevice] model] rangeOfString:@"iPod"].location != NSNotFound) {
        return NO;
    }

    return YES;
}

#pragma mark - Status Bar Introspection -

+ (UIWindow *)statusBarWindow
{
    return (UIWindow *)[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"];
}

+ (UIView *)systemStatusBarModern:(BOOL *)modern
{
    if (_systemStatusBar) { return _systemStatusBar; }

    UIWindow *statusBarWindow = [[self class] statusBarWindow];
    if (statusBarWindow == nil) { return nil; }

    for (UIView *subview in statusBarWindow.subviews) {
        if ([NSStringFromClass([subview class]) isEqualToString:@"UIStatusBar"]) {
            *modern = NO;
            return subview;
        }

        if ([NSStringFromClass([subview class]) isEqualToString:@"UIStatusBar_Modern"]) {
            *modern = YES;
            return subview;
        }
    }

    return nil;
}

@end
