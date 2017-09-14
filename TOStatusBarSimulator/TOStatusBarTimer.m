//
//  TOStatusBarTimer.m
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

#import "TOStatusBarTimer.h"

@interface TOStatusBarTimer ()

@property (nonatomic, copy, readwrite) NSString *currentTime;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation TOStatusBarTimer

- (instancetype)init
{
    if (self = [super init]) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateStyle = NSDateFormatterNoStyle;
        _dateFormatter.timeStyle = NSDateFormatterShortStyle;

        _calendar = [NSCalendar currentCalendar];
    }

    return self;
}

- (void)dealloc
{
    [self stop];
}

- (void)start
{
    [self timerTriggered];
}

- (void)stop
{
    if (self.timer) {
        [self.timer invalidate];
        
    }
}

- (void)timerTriggered
{
    NSDate *date = [NSDate date];

    
    self.currentTime = [self.dateFormatter stringFromDate:date];
    if (self.timeChangedHandler) {
        self.timeChangedHandler(self.currentTime);
    }

    NSInteger seconds = [_calendar component:NSCalendarUnitSecond fromDate:date];
    NSInteger remainingSeconds = 60 - seconds;

    self.timer = [NSTimer scheduledTimerWithTimeInterval:remainingSeconds target:self selector:@selector(timerTriggered) userInfo:nil repeats:NO];
}

- (void)setHideAMPM:(BOOL)hideAMPM
{
    if (_hideAMPM == hideAMPM) { return; }
    _hideAMPM = hideAMPM;

    if (_hideAMPM) {
        _dateFormatter.dateFormat = @"h:mm";
    }
    else {
        _dateFormatter.dateFormat = nil;
    }
}

@end
