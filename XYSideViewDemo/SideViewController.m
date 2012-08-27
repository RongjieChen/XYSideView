//
//  SideViewController.m
//  XYSideViewDemo
//
//  Created by Samuel Liu on 8/24/12.
//  Copyright (c) 2012 Samuel Liu. All rights reserved.
//

#import "SideViewController.h"

@interface SideViewController ()

@end

@implementation SideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor blueColor];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:48];
    label.textColor = [UIColor yellowColor];
    label.text = @"XYSideViewDemo";
    [label sizeToFit];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(100, 100, 160, 30);
    [button setTitle:@"dismiss" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismissSideView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:label];
    [self.view addSubview:button];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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

-(void)dismissSideView:(id)sender
{
    [self dismissSideViewControllerAnimated:YES];
}

@end
