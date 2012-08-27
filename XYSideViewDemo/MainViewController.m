//
//  MainViewController.m
//  XYSideViewDemo
//
//  Created by Samuel Liu on 8/24/12.
//  Copyright (c) 2012 Samuel Liu. All rights reserved.
//

#import "MainViewController.h"
#import "SideViewController.h"

@interface MainViewController ()
{
    SideViewController *sideViewController;
}

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *buttonTop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonTop.frame = CGRectMake(380, 200, 180, 40);
    buttonTop.tag = XYSideViewDirectionTop;
    [buttonTop setTitle:@"Top" forState:UIControlStateNormal];
    [buttonTop addTarget:self action:@selector(presentSideView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonLeft = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonLeft.frame = CGRectMake(200, 260, 180, 40);
    buttonLeft.tag = XYSideViewDirectionLeft;
    [buttonLeft setTitle:@"Left" forState:UIControlStateNormal];
    [buttonLeft addTarget:self action:@selector(presentSideView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonBottom = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonBottom.frame = CGRectMake(380, 320, 180, 40);
    buttonBottom.tag = XYSideViewDirectionBottom;
    [buttonBottom setTitle:@"Bottom" forState:UIControlStateNormal];
    [buttonBottom addTarget:self action:@selector(presentSideView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonRight = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonRight.frame = CGRectMake(560, 260, 180, 40);
    buttonRight.tag = XYSideViewDirectionRight;
    [buttonRight setTitle:@"Right" forState:UIControlStateNormal];
    [buttonRight addTarget:self action:@selector(presentSideView:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:buttonTop];
    [self.view addSubview:buttonLeft];
    [self.view addSubview:buttonBottom];
    [self.view addSubview:buttonRight];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(void)presentSideView:(id)sender
{
    sideViewController = [[SideViewController alloc] init];
    [sideViewController presentSideViewControllerFromDirection:((UIButton*)sender).tag animated:YES];
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self.flipsidePopoverController dismissPopoverAnimated:YES];
}

- (IBAction)showInfo:(id)sender
{
    if (!self.flipsidePopoverController) {
        FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
        controller.delegate = self;
        
        self.flipsidePopoverController = [[UIPopoverController alloc] initWithContentViewController:controller];
    }
    if ([self.flipsidePopoverController isPopoverVisible]) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
    } else {
        [self.flipsidePopoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

@end
