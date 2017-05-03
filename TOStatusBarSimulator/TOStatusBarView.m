//
//  TOStatusBarView.m
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

#import "TOStatusBarView.h"

@interface TOStatusBarView ()

@property (nonatomic, strong) UIImageView *signalStrengthView;
@property (nonatomic, strong) UILabel *carrierStringLabel;
@property (nonatomic, strong) UIImageView *wifiView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *batteryLevelLabel;
@property (nonatomic, strong) UIImageView *batteryLevelView;

@end

@implementation TOStatusBarView

- (void)didMoveToSuperview
{
    self.tintColor = [UIColor blackColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    [super didMoveToSuperview];
    [self setUpSignalStrengthView];
    [self setUpCarrierLabel];
    [self setUpWifiView];
    [self setUpTimeLabel];
    [self setUpBatteryIcon];
    [self setUpBatteryLabel];
}

- (void)setUpSignalStrengthView
{
    if (self.signalStrengthView || !self.showSignalStrength) { return; }

    UIImage *signalStrengthImage = [[UIImage imageNamed:@"SignalStrength"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.signalStrengthView = [[UIImageView alloc] initWithImage:signalStrengthImage];
    self.signalStrengthView.contentMode = UIViewContentModeCenter;
    [self addSubview:self.signalStrengthView];
}

- (void)setUpCarrierLabel
{
    if (self.carrierString.length == 0 || self.carrierStringLabel) { return; }

    self.carrierStringLabel = [[UILabel alloc] init];
    self.carrierStringLabel.font = [UIFont systemFontOfSize:12.0f];
    self.carrierStringLabel.textColor = self.tintColor ? self.tintColor : [UIColor blackColor];
    self.carrierStringLabel.text = self.carrierString;
    [self addSubview:self.carrierStringLabel];
}

- (void)setUpWifiView
{
    if (self.wifiView) { return; }

    UIImage *wifiIcon = [[UIImage imageNamed:@"WiFi"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.wifiView = [[UIImageView alloc] initWithImage:wifiIcon];
    self.wifiView.contentMode = UIViewContentModeCenter;
    [self addSubview:self.wifiView];
}

- (void)setUpTimeLabel
{
    if (self.timeLabel) { return; }

    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightSemibold];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.text = @"9:41 AM";
    [self.timeLabel sizeToFit];
    [self addSubview:self.timeLabel];
}

- (void)setUpBatteryLabel
{
    if (self.batteryLevelLabel) { return; }

    self.batteryLevelLabel = [[UILabel alloc] init];
    self.batteryLevelLabel.font = [UIFont systemFontOfSize:12.0f];
    self.batteryLevelLabel.textAlignment = NSTextAlignmentRight;
    self.batteryLevelLabel.text = @"100%";
    [self.batteryLevelLabel sizeToFit];
    [self addSubview:self.batteryLevelLabel];
}

- (void)setUpBatteryIcon
{
    if (self.batteryLevelView) { return; }

    UIImage *batteryImage = [[UIImage imageNamed:@"Battery"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.batteryLevelView = [[UIImageView alloc] initWithImage:batteryImage];
    self.batteryLevelView.contentMode = UIViewContentModeCenter;
    [self addSubview:self.batteryLevelView];
}

- (void)setTintColor:(UIColor *)tintColor
{
    [self setTintColor:tintColor animated:NO];
}

- (void)setTintColor:(UIColor *)tintColor animated:(BOOL)animated
{
    UIView *snapshotView = nil;
    if (animated) {
        snapshotView = [self snapshotViewAfterScreenUpdates:NO];
        snapshotView.frame = self.frame;
        [self.superview addSubview:snapshotView];
    }

    [super setTintColor:tintColor];

    self.carrierStringLabel.textColor = tintColor;
    self.timeLabel.textColor = tintColor;
    self.batteryLevelLabel.textColor = tintColor;

    if (animated) {
        [UIView animateWithDuration:0.35f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.1f options:0 animations:^{
            snapshotView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [snapshotView removeFromSuperview];
        }];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGRect frame = CGRectZero;

    CGFloat x = 6.5f;
    if (self.signalStrengthView) {
        frame.size = self.signalStrengthView.frame.size;
        frame.origin.x = x;
        frame.origin.y = floorf(10.0f - (frame.size.height * 0.5f));
        self.signalStrengthView.frame = frame;

        x += frame.size.width + 6.0f;
    }

    if (self.carrierStringLabel) {
        [self.carrierStringLabel sizeToFit];
        frame = self.carrierStringLabel.frame;
        frame.origin.x = x;
        frame.origin.y = ceilf((CGRectGetHeight(self.frame) - frame.size.height) * 0.5f);
        self.carrierStringLabel.frame = frame;
        x = CGRectGetMaxX(frame) + 5.0f;
    }

    frame.origin.x = x;
    frame.origin.y = 5.5f;
    frame.size = self.wifiView.frame.size;
    self.wifiView.frame = frame;

    [self.timeLabel sizeToFit];
    frame = self.timeLabel.frame;
    frame.size.height = 20.0f;
    frame.origin.y = 0.0f;
    frame.origin.x = ceilf((self.frame.size.width - frame.size.width) * 0.5f) + 2.0f;
    self.timeLabel.frame = frame;

    frame = self.batteryLevelView.frame;
    frame.origin.x = CGRectGetWidth(self.frame) - (frame.size.width + 5.5f);
    frame.origin.y = ceilf((CGRectGetHeight(self.frame) - frame.size.height) * 0.5f);
    self.batteryLevelView.frame = frame;

    [self.batteryLevelLabel sizeToFit];
    frame = self.batteryLevelLabel.frame;
    frame.origin.x = CGRectGetMinX(self.batteryLevelView.frame) - (frame.size.width + 3.0f);
    frame.origin.y = ceilf((CGRectGetHeight(self.frame) - frame.size.height) * 0.5f);
    self.batteryLevelLabel.frame = frame;
}

#pragma mark - Accessors -
- (void)setCarrierString:(NSString *)carrierString
{
    _carrierString = carrierString;
    [self setUpCarrierLabel];
    [self setNeedsLayout];
}

@end
