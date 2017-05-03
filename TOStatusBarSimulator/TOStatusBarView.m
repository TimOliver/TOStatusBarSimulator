//
//  TOStatusBarView.m
//  TOStatusBarSimulator
//
//  Created by Tim Oliver on 5/2/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

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
    [self addSubview:self.signalStrengthView];
}

- (void)setUpCarrierLabel
{
    if (self.carrierString.length == 0 || self.carrierStringLabel) { return; }

    self.carrierStringLabel = [[UILabel alloc] init];
    self.carrierStringLabel.font = [UIFont systemFontOfSize:11.0f];
    self.carrierStringLabel.textColor = self.tintColor ? self.tintColor : [UIColor blackColor];
    self.carrierStringLabel.text = self.carrierString;
    [self addSubview:self.carrierStringLabel];
}

- (void)setUpWifiView
{
    if (self.wifiView) { return; }

    UIImage *wifiIcon = [[UIImage imageNamed:@"WiFi"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.wifiView = [[UIImageView alloc] initWithImage:wifiIcon];
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

    CGFloat x = 3.0f;
    if (self.signalStrengthView) {
        frame.size = self.signalStrengthView.frame.size;
        frame.origin.x = x;
        frame.origin.y = 10.0f - (frame.size.height * 0.5f);
        self.signalStrengthView.frame = frame;

        x += frame.size.width + 3.0f;
    }

    frame.origin.x = x;
    frame.origin.y = 6.0f;
    frame.size = self.wifiView.frame.size;
    self.wifiView.frame = frame;

    [self.timeLabel sizeToFit];
    frame = self.timeLabel.frame;
    frame.size.height = 20.0f;
    frame.origin.y = 0.0f;
    frame.origin.x = ceilf((self.frame.size.width - frame.size.width) * 0.5f) + 2.0f;
    self.timeLabel.frame = frame;
}

@end
