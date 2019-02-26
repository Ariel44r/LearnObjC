//
//  UIViewController+_Extension.m
//  LearnObjC
//
//  Created by ARIEL DIAZ on 2/20/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "LearnObjC-Swift.h"

@implementation UIViewController (Extension)

+ (UIViewController *)topViewController{
    UIViewController *topController = [[UIApplication sharedApplication].delegate window].rootViewController;
    while (topController.presentedViewController){
        topController = topController.presentedViewController;
    }
    if ([topController isKindOfClass:UINavigationController.class]){
        topController = ((UINavigationController *)topController).topViewController;
    }
    return topController;
    
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"canRotateViewControllerFlag"])
        return UIInterfaceOrientationMaskAll;
    else
        return UIInterfaceOrientationMaskPortrait;
    //    return self.canRotate ? UIInterfaceOrientationMask
}

@end
