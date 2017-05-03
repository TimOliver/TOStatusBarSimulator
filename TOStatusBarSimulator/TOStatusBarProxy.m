//
//  TOStatusBarProxy.m
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

#import "TOStatusBarProxy.h"
#import "UIApplication+CaptureAnimation.h"
#import "TOStatusBarView.h"
#import <UIKit/UIKit.h>

@interface TOStatusBarProxy ()

@property (nonatomic, strong) UIView *systemBar;
@property (nonatomic, strong) TOStatusBarView *simulatedBar;

@end

@implementation TOStatusBarProxy

- (instancetype)initWithSystemStatusBar:(UIView *)systemBar simulatedStatusBar:(UIView *)simulatedBar
{
    if (self = [super init]) {
        _systemBar = systemBar;
        _simulatedBar = (TOStatusBarView *)simulatedBar;

        [self attachNotifications];
    }

    return self;
}

- (void)dealloc
{
    [self removeNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kTOStatusBarStyleChangedNotification object:nil];
}

- (void)attachNotifications
{
    [self.systemBar addObserver:self forKeyPath:@"alpha" options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(styleNotification:) name:kTOStatusBarStyleChangedNotification object:nil];
}

- (void)removeNotifications
{
    [self.systemBar removeObserver:self forKeyPath:@"alpha"];
}

- (void)styleNotification:(NSNotification *)notification
{
    UIStatusBarStyle style = [[UIApplication sharedApplication] statusBarStyle];
    UIColor *color = style == UIStatusBarStyleLightContent ? [UIColor whiteColor] : [UIColor blackColor];
    [self.simulatedBar setTintColor:color animated:YES];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    // TODO: Animate me
    if ([keyPath isEqualToString:@"alpha"]) {
        self.simulatedBar.alpha = self.systemBar.alpha;
    }
}

@end
