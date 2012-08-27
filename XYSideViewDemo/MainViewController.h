//
//  MainViewController.h
//  XYSideViewDemo
//
//  Created by Samuel Liu on 8/24/12.
//  Copyright (c) 2012 Samuel Liu. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

- (IBAction)showInfo:(id)sender;

@end
