//
//  ViewController.m
//  TOStatusBarSimulator
//
//  Created by Tim Oliver on 5/2/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "ViewController.h"
#import "DarkViewController.h"
#import "TOStatusBarSimulator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *toggleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    toggleButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [toggleButton setTitle:@"Show Dark View" forState:UIControlStateNormal];
    [toggleButton sizeToFit];
    toggleButton.center = self.view.center;
    [toggleButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toggleButton];
}

- (void)buttonTapped:(id)sender
{
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[DarkViewController new]];
    navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
