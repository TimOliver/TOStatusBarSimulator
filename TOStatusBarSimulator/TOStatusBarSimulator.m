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

static UIView *_systemStatusBar;
static TOStatusBarView *_statusBar;

@implementation TOStatusBarSimulator

+ (void)show
{
    if (_systemStatusBar) { return; }
    _systemStatusBar = [[self class] systemStatusBar];

    [_systemStatusBar removeFromSuperview];

    UIWindow *statusBarWindow = [[self class] statusBarWindow];

    _statusBar = [[TOStatusBarView alloc] initWithFrame:(CGRect){0,0,statusBarWindow.frame.size.width, 20.0f}];
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

@end
