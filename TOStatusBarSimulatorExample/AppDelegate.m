//
//  AppDelegate.m
//  TOStatusBarSimulator
//
//  Created by Tim Oliver on 5/2/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "TOStatusBarSimulator.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = nc;
    [self.window makeKeyAndVisible];

    [TOStatusBarSimulator show];

    return YES;
}

@end
