//
//  TOStatusBarSimulator.m
//  TOStatusBarSimulator
//
//  Created by Tim Oliver on 5/2/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOStatusBarSimulator.h"
#import <UIKit/UIKit.h>

static UIView *_systemStatusBar;


@implementation TOStatusBarSimulator

+ (void)show
{
    if (_systemStatusBar) { return; }
    _systemStatusBar = [[self class] systemStatusBar];

    _systemStatusBar.alpha = 0.0f;

    UIWindow *statusBarWindow = [[self class] statusBarWindow];

    UIView *test = [[UIView alloc] initWithFrame:CGRectMake(0, 0, statusBarWindow.frame.size.width, 20)];
    test.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    test.backgroundColor = [UIColor redColor];
    [[[self class] statusBarWindow] addSubview:test];
}

+ (UIWindow *)statusBarWindow
{
    return (UIWindow *)[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"];
}

+ (UIView *)systemStatusBar
{
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
