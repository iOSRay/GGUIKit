//
//  UIView+LayoutConstraintHelper.h
//  Beansmile
//
//  Created by John on 9/5/14.
//

#import <UIKit/UIKit.h>

@interface UIView (LayoutConstraintHelper)

- (NSLayoutConstraint*)widthConstraint;
- (NSLayoutConstraint*)heightConstraint;

- (void)layoutConstraintWithIdentifier:(NSString *)identifier constant:(CGFloat)constant;
- (void)layoutConstraint:(NSLayoutAttribute)layoutAttribute secondItem:(UIView *)secondItem secondAttribute:(NSLayoutAttribute)secondAttribute offset:(CGFloat)offset;
@end
