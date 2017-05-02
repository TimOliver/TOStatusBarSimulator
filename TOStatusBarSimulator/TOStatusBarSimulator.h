//
//  TOStatusBarSimulator.h
//  TOStatusBarSimulator
//
//  Created by Tim Oliver on 5/2/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TOStatusBarSimulator : NSObject

/* Replaces the system status bar with a simulated one */
+ (void)show;

/* Clears the simulated status bar and restores the proper one. */
+ (void)hide;

/* By default, the time will always read "9:41 AM". Change this to show the actual Time. */
+ (void)showActualTime:(BOOL)actualTime;

/* Default is hidden on iPhone, "iPad" on iPad, and "iPod" on iPod touch. */
+ (void)setCarrierString:(NSString *)carrierString;

/* Signal strength is normally only shown on iPhone, but can be shown on others. */
+ (void)alwaysShowSignalStrength:(BOOL)showSignalStrength;

@end
