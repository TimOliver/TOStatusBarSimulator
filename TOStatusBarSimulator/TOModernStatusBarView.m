//
//  TOModernStatusBarView.m
//  TOStatusBarSimulator
//
//  Created by Tim Oliver on 9/14/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOModernStatusBarView.h"

@interface TOModernStatusBarView ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation TOModernStatusBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }

    return self;
}

- (void)setUp
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];

    // Right hand content
    UIImage *modernImage = [[UIImage imageNamed:@"Modern-11" inBundle:bundle compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.rightImageView = [[UIImageView alloc] initWithImage:modernImage];
    [self addSubview:self.rightImageView];

    // Time Label
    self.timeLabel = [[UILabel alloc] initWithFrame:(CGRect){0,0,43,18}];
    self.timeLabel.text = @"9:41";
    self.timeLabel.lineBreakMode = NSLineBreakByClipping;
    self.timeLabel.font = [UIFont systemFontOfSize:15.0f weight:UIFontWeightSemibold];
    [self addSubview:self.timeLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGRect frame = self.rightImageView.frame;
    frame.origin.y = 17.333f;
    frame.origin.x = 293.666f;
    self.rightImageView.frame = frame;

    frame = self.timeLabel.frame;
    frame.origin.x = 26.0f;
    frame.origin.y = 14.0f;
    self.timeLabel.frame = frame;
}

- (void)setTimeString:(NSString *)timeString
{
    if (timeString == _timeString) { return; }
    _timeString = [timeString copy];
    self.timeLabel.text = _timeString.length > 0 ? _timeString : @"9:41";
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

    self.rightImageView.tintColor = tintColor;
    self.timeLabel.textColor = tintColor;

    if (animated) {
        [UIView animateWithDuration:0.35f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.1f options:0 animations:^{
            snapshotView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [snapshotView removeFromSuperview];
        }];
    }
}

@end
