//
//  UIView+GGProgressHUD.h
//  Beansmile
//
//  Created by John on 2017/10/11.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIView (GGProgressHUD)

- (void)showLoadingHorizontalCenterWithAnimation:(BOOL)animation;
- (void)showLoadingWithAnimation:(BOOL)animation;
- (void)showLoadingWithAnimation:(BOOL)animation offset:(CGFloat)offset;
- (void)showLoadingWithAnimation:(BOOL)animation afterDelay:(NSTimeInterval)delay;

- (void)showLoadingWithText:(NSString *)text animation:(BOOL)animation;

- (void)showText:(NSString *)text animation:(BOOL)animation autoHide:(BOOL)autoHide;

- (void)showText:(NSString *)text offset:(CGFloat)offset animation:(BOOL)animation autoHide:(BOOL)autoHide;

- (void)showSuccessText:(NSString *)text animation:(BOOL)animation autoHide:(BOOL)autoHide;

- (void)showErrorText:(NSString *)text animation:(BOOL)animation autoHide:(BOOL)autoHide;

- (void)showText:(NSString *)text imageName:(NSString *)imageName autoHide:(BOOL)autoHide;

- (void)hideHUD:(BOOL)animated;

@end
