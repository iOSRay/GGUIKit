//
//  UIViewController+GGTool.m
//  Beansmile
//
//  Created by John on 11/01/2018.
//

#import "UIViewController+GGTool.h"

@implementation UIViewController (GGTool)

+ (UIViewController*)findBestViewController:(UIViewController*)vc {
    if (vc.presentedViewController) {
        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0){
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        }else{
            return vc;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0){
            return [UIViewController findBestViewController:svc.topViewController];
        }
        else{
            return vc;
        }
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0){
            return [UIViewController findBestViewController:svc.selectedViewController];
        }
        else{
            return vc;
        }
    } else {
        return vc;
    }
}

+ (UIViewController*)currentViewController {
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findBestViewController:viewController];
}

- (void)popGestureClose {
    // 禁用侧滑返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //这里对添加到右滑视图上的所有手势禁用
        for (UIGestureRecognizer *popGesture in self.navigationController.interactivePopGestureRecognizer.view.gestureRecognizers) {
            popGesture.enabled = NO;
        }
    }
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        UINavigationController *navigationController = self;
        //这里对添加到右滑视图上的所有手势禁用
        for (UIGestureRecognizer *popGesture in navigationController.interactivePopGestureRecognizer.view.gestureRecognizers) {
            popGesture.enabled = NO;
        }
    }
}

- (void)popGestureOpen {
    // 启用侧滑返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //这里对添加到右滑视图上的所有手势启用
        for (UIGestureRecognizer *popGesture in self.navigationController.interactivePopGestureRecognizer.view.gestureRecognizers) {
            popGesture.enabled = YES;
        }
    }
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        UINavigationController *navigationController = self;
        //这里对添加到右滑视图上的所有手势启用
        for (UIGestureRecognizer *popGesture in navigationController.interactivePopGestureRecognizer.view.gestureRecognizers) {
            popGesture.enabled = YES;
        }
    }
}
@end
