//
//  TOModernStatusBarView.h
//  TOStatusBarSimulator
//
//  Created by Tim Oliver on 9/14/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TOStatusBarProxy.h"

@interface TOModernStatusBarView : UIView <TOAnimatedTintColor>

@property (nonatomic, copy) NSString *timeString;

- (void)setTintColor:(UIColor *)tintColor animated:(BOOL)animated;

@end
