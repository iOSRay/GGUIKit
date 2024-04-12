//
//  UIViewController+GGTool.h
//  Beansmile
//
//  Created by John on 11/01/2018.
//

#import <UIKit/UIKit.h>

@interface UIViewController (GGTool)

+ (UIViewController *)currentViewController;
- (void)popGestureClose;
- (void)popGestureOpen;
@end
