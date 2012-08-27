//
//  UIViewController+XYSideView.h
//  XYSideViewDemo
//
//  Created by Samuel Liu on 8/24/12.
//  Copyright (c) 2012 Samuel Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    XYSideViewDirectionTop = 0,
    XYSideViewDirectionLeft = 1,
    XYSideViewDirectionBottom = 2,
    XYSideViewDirectionRight = 3,
    XYSideViewDirectionDefault = XYSideViewDirectionRight
} XYSideViewDirection;

@interface UIViewController (XYSideView)

-(void)presentSideViewControllerFromDirection:(XYSideViewDirection)direction animated:(BOOL)animated;
-(void)dismissSideViewControllerAnimated:(BOOL)animated;

@end
