//
//  TOStatusBarView.h
//  TOStatusBarSimulator
//
//  Created by Tim Oliver on 5/2/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TOStatusBarView : UIView

@property (nonatomic, assign) BOOL showSignalStrength;
@property (nonatomic, copy) NSString *carrierString;
@property (nonatomic, assign) BOOL realTime;

- (void)setTintColor:(UIColor *)tintColor animated:(BOOL)animated;

@end
