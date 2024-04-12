//
//  UIView+GGProgressHUD.m
//  Beansmile
//
//  Created by John on 2017/10/11.
//

#import "UIView+GGProgressHUD.h"
#import <PureLayout.h>

@implementation UIView (GGProgressHUD)

+ (void)load {
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
}

- (void)showLoadingWithAnimation:(BOOL)animation offset:(CGFloat)offset {
    [self hideHUD:animation];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:animation];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithRed:0 / 255 green:0 / 255 blue:0 / 255 alpha:0.75];
    [hud hideAnimated:animation afterDelay:20];
    [self updateFrameForHUD:hud offset:offset];
}

- (void)showLoadingWithAnimation:(BOOL)animation {
    [self showLoadingWithAnimation:animation offset:0.f];
}

- (void)showLoadingHorizontalCenterWithAnimation:(BOOL)animation {
    [self hideHUD:animation];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:animation];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithRed:0 / 255 green:0 / 255 blue:0 / 255 alpha:0.75];
    [hud hideAnimated:animation afterDelay:20];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [hud autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
        [hud autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
//        [hud autoSetDimensionsToSize:CGSizeMake(154, 154)];
        [hud autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20 relation:NSLayoutRelationGreaterThanOrEqual];
        [hud autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20 relation:NSLayoutRelationGreaterThanOrEqual];
    });
}

- (void)showLoadingWithAnimation:(BOOL)animation afterDelay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:animation];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithRed:0 / 255 green:0 / 255 blue:0 / 255 alpha:0.75];
    [hud hideAnimated:animation afterDelay:delay];
    [self updateFrameForHUD:hud offset:0.f];
}

- (void)showLoadingWithText:(NSString *)text animation:(BOOL)animation{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:animation];
    hud.detailsLabel.text = text;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithRed:0 / 255 green:0 / 255 blue:0 / 255 alpha:0.75];
    [hud hideAnimated:animation afterDelay:20];
    [self updateFrameForHUD:hud offset:0.f];
}

- (void)showText:(NSString *)text animation:(BOOL)animation autoHide:(BOOL)autoHide {
    [self showText:text offset:0.f animation:animation autoHide:autoHide];
}

- (void)showText:(NSString *)text offset:(CGFloat)offset animation:(BOOL)animation autoHide:(BOOL)autoHide {
    if (text.length<=0 || !text) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:animation];
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    hud.detailsLabel.numberOfLines = 10;
    hud.contentColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor colorWithRed:0 / 255 green:0 / 255 blue:0 / 255 alpha:0.75];
    [self updateFrameForHUD:hud offset:offset];

    if (autoHide) {
        [hud hideAnimated:animation afterDelay:1.5];
    }
}

- (void)showSuccessText:(NSString *)text animation:(BOOL)animation autoHide:(BOOL)autoHide{
    if (text.length<=0 || !text) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:animation];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_toast_success"]];
    hud.detailsLabel.font = [UIFont systemFontOfSize:12];
    hud.detailsLabel.text = text;
    hud.contentColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithRed:0 / 255 green:0 / 255 blue:0 / 255 alpha:0.75];
    [self updateFrameForHUD:hud offset:0.f];

    if (autoHide) {
        [hud hideAnimated:animation afterDelay:1.5];
    }
}

- (void)showErrorText:(NSString *)text animation:(BOOL)animation autoHide:(BOOL)autoHide{
    if (text.length<=0 || !text) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:animation];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"failhud"]];
    hud.detailsLabel.font = [UIFont systemFontOfSize:12];
    hud.detailsLabel.text = text;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor blackColor];
    hud.mode = MBProgressHUDModeCustomView;
    
    if (autoHide) {
        [hud hideAnimated:animation afterDelay:1.5];
    }
}

- (void)showText:(NSString *)text imageName:(NSString *)imageName autoHide:(BOOL)autoHide{
    if (text.length<=0 || !text || !imageName) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    hud.label.text = text;
    hud.label.font = [UIFont systemFontOfSize:14];
    hud.label.numberOfLines = 10;
    hud.contentColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithRed:0 / 255 green:0 / 255 blue:0 / 255 alpha:0.75];
    
    if (autoHide) {
        [hud hideAnimated:YES afterDelay:1.5];
    }
}

- (void)hideHUD:(BOOL)animated {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
    if (hud && (hud.mode == MBProgressHUDModeCustomView || hud.mode == MBProgressHUDModeText)) {
        [hud hideAnimated:animated afterDelay:1.5];
        return;
    }
    [MBProgressHUD hideHUDForView:self animated:animated];
}

- (void)updateFrameForHUD:(MBProgressHUD *)hud offset:(CGFloat)offsetY {
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat offset = offsetY > 0 ? offsetY : (kScreenHeight - self.height) * 0.4;
        [hud autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:-offset];
        [hud autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
//        [hud autoSetDimensionsToSize:CGSizeMake(154, 154)];
        [hud autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20 relation:NSLayoutRelationGreaterThanOrEqual];
        [hud autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20 relation:NSLayoutRelationGreaterThanOrEqual];
    });
}

@end
