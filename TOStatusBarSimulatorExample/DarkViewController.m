//
//  DarkViewController.m
//  TOStatusBarSimulator
//
//  Created by Tim Oliver on 5/2/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "DarkViewController.h"

@interface DarkViewController ()

@end

@implementation DarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.1f alpha:1.0f];
    self.title = @"Dark Theme";

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped:)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (void)doneButtonTapped:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
