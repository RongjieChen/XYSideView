//
//  UIViewController+XYSideView.m
//  XYSideViewDemo
//
//  Created by Samuel Liu on 8/24/12.
//  Copyright (c) 2012 Samuel Liu. All rights reserved.
//

#import "UIViewController+XYSideView.h"

@implementation UIViewController (XYSideView)

#define SideViewWidth 480.0f
#define SideViewHeight 640.0f
#define SideShadowWidth 5.0f
#define SideAnimateDuration 0.2f

UIView *sideBGView;
UIView *sideContentView;
UIView *sideShadowView;

XYSideViewDirection currentDirection;

-(UIView*)keyWindowView
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if(!keyWindow)
    {
        NSArray *windows = [UIApplication sharedApplication].windows;
        if(windows.count > 0) keyWindow = [windows lastObject];
        keyWindow = [windows objectAtIndex:0];
    }
    
    UIView *containerView = [[keyWindow subviews] objectAtIndex:0];
    return containerView;
}

-(void)layoutSideViewsForInitialState
{
    UIView *keyWindowView = [self keyWindowView];
    
    float _width = keyWindowView.frame.size.width;
    float _height = keyWindowView.frame.size.height;
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
    {
        _width = keyWindowView.frame.size.height;
        _height = keyWindowView.frame.size.width;
    }

    sideBGView.frame = CGRectMake(0, 0, _width, _height);
    sideBGView.alpha = 0.0f;

    switch (currentDirection)
    {
        case XYSideViewDirectionTop:
        {
            sideContentView.frame = CGRectMake((_width - SideViewWidth) / 2, -SideViewHeight, SideViewWidth, SideViewHeight);
            sideShadowView.hidden = YES;
            
            break;
        }
        case XYSideViewDirectionLeft:
        {
            sideContentView.frame = CGRectMake(-SideViewWidth, 0, SideViewWidth, _height);
            sideShadowView.frame = CGRectMake(sideContentView.frame.origin.x + SideViewWidth, 0, SideShadowWidth, _height);
            
            break;
        }
        case XYSideViewDirectionBottom:
        {
            sideContentView.frame = CGRectMake((_width - SideViewWidth) / 2, _height, SideViewWidth, SideViewHeight);
            sideShadowView.hidden = YES;
            
            break;
        }
        case XYSideViewDirectionRight:
        {
            sideContentView.frame = CGRectMake(_width, 0, SideViewWidth, _height);
            sideShadowView.frame = CGRectMake(sideContentView.frame.origin.x - SideShadowWidth, 0, SideShadowWidth, _height);
            
            break;
        }
        default:
            break;
    }
}

-(void)layoutSideViews
{
    UIView *keyWindowView = [self keyWindowView];
    
    float _width = keyWindowView.frame.size.width;
    float _height = keyWindowView.frame.size.height;
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
    {
        _width = keyWindowView.frame.size.height;
        _height = keyWindowView.frame.size.width;
    }
    
    sideBGView.frame = CGRectMake(0, 0, _width, _height);
    sideBGView.alpha = 0.5f;

    switch (currentDirection)
    {
        case XYSideViewDirectionTop:
        {
            sideContentView.frame = CGRectMake((_width - SideViewWidth) / 2, 0, SideViewWidth, SideViewHeight);

            break;
        }
        case XYSideViewDirectionLeft:
        {
            sideContentView.frame = CGRectMake(0, 0, SideViewWidth, _height);
            sideShadowView.frame = CGRectMake(SideViewWidth, 0, SideShadowWidth, _height);
            
            break;
        }
        case XYSideViewDirectionBottom:
        {
            sideContentView.frame = CGRectMake((_width - SideViewWidth) / 2, _height - SideViewHeight, SideViewWidth, SideViewHeight);
            
            break;
        }
        case XYSideViewDirectionRight:
        {
            sideContentView.frame = CGRectMake(_width - SideViewWidth, 0, SideViewWidth, _height);
            sideShadowView.frame = CGRectMake(sideContentView.frame.origin.x - SideShadowWidth, 0, SideShadowWidth, _height);

            break;
        }
        default:
            break;
    }
}

-(void)presentSideViewControllerFromDirection:(XYSideViewDirection)direction animated:(BOOL)animated
{
    UIView *keyWindowView = [self keyWindowView];

    currentDirection = direction;

    sideBGView = [[UIView alloc] init];
    sideBGView.backgroundColor = [UIColor blackColor];
    sideBGView.opaque = YES;
    [keyWindowView addSubview:sideBGView];
    
    sideContentView = [[UIView alloc] init];
    sideContentView.backgroundColor = [UIColor redColor];
    [keyWindowView addSubview:sideContentView];
    
    sideShadowView = [[UIView alloc] init];
    sideShadowView.backgroundColor = [UIColor greenColor];
    [keyWindowView addSubview:sideShadowView];
    
    [self layoutSideViewsForInitialState];
    
    self.view.frame = sideContentView.bounds;
    [sideContentView addSubview:self.view];

    float duration = SideAnimateDuration;
    if(!animated) duration = 0.0f;
    
    [UIView animateWithDuration:duration
                     animations:^{
                         [self layoutSideViews];
                     }];
}

-(void)dismissSideViewControllerAnimated:(BOOL)animated
{
    float duration = SideAnimateDuration;
    if(!animated) duration = 0.0f;

    [UIView animateWithDuration:duration
                     animations:^{
                         [self layoutSideViewsForInitialState];
                     }
                     completion:^(BOOL finished) {
                         [self.view removeFromSuperview];
                         [sideContentView removeFromSuperview];
                         [sideShadowView removeFromSuperview];
                         [sideBGView removeFromSuperview];
                         
                         sideContentView = nil;
                         sideShadowView = nil;
                         sideBGView = nil;
                     }];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

-(void)viewDidAppear:(BOOL)animated
{
    if(sideContentView)
        [self layoutSideViews];
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if(sideContentView)
        [self layoutSideViews];
}

#pragma clang diagnostic pop

@end
