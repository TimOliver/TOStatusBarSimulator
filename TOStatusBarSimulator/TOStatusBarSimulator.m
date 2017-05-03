//
//  TOStatusBarSimulator.m
//  TOStatusBarSimulator
//
//  Created by Tim Oliver on 5/2/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOStatusBarSimulator.h"
#import "TOStatusBarView.h"
#import <UIKit/UIKit.h>

static UIView *_systemStatusBar = nil;
static TOStatusBarView *_statusBar = nil;
static NSString *_carrierString = nil;
static BOOL _alwaysShowSignalStrength = NO;

@implementation TOStatusBarSimulator

+ (void)show
{
    if (_systemStatusBar) { return; }
    _systemStatusBar = [[self class] systemStatusBar];

    [_systemStatusBar removeFromSuperview];

    UIWindow *statusBarWindow = [[self class] statusBarWindow];

    _statusBar = [[TOStatusBarView alloc] initWithFrame:(CGRect){0, 0, statusBarWindow.frame.size.width, 20.0f}];
    _statusBar.carrierString = _carrierString ?: [[self class] defaultCarrierString];
    _statusBar.showSignalStrength = (_alwaysShowSignalStrength || [[self class] signalStrengthVisibleByDefault]);
    [statusBarWindow addSubview:_statusBar];
}

+ (UIWindow *)statusBarWindow
{
    return (UIWindow *)[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"];
}

+ (UIView *)systemStatusBar
{
    if (_systemStatusBar) { return _systemStatusBar; }

    UIWindow *statusBarWindow = [[self class] statusBarWindow];
    if (statusBarWindow == nil) { return nil; }

    for (UIView *subview in statusBarWindow.subviews) {
        if ([NSStringFromClass([subview class]) isEqualToString:@"UIStatusBar"]) {
            return subview;
        }
    }

    return nil;
}

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

+ (void)alwaysShowSignalStrength:(BOOL)showSignalStrength
{
    _alwaysShowSignalStrength = showSignalStrength;
    _statusBar.showSignalStrength = (_alwaysShowSignalStrength || [[self class] signalStrengthVisibleByDefault]);
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

+ (void)setCarrierString:(NSString *)carrierString
{
    _carrierString = carrierString;
    _statusBar.carrierString = carrierString ?: [[self class] defaultCarrierString];
}

@end
