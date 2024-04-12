//
//  UIView+LayoutConstraintHelper.m
//  Beansmile
//
//  Created by John on 9/5/14.
//

#import "UIView+LayoutConstraintHelper.h"

@implementation UIView (LayoutConstraintHelper)

- (NSLayoutConstraint *)widthConstraint {
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeWidth && !constraint.secondItem && constraint.relation == NSLayoutRelationEqual && constraint.priority == UILayoutPriorityRequired) {
            return constraint;
        }
    }
    return nil;
}

- (NSLayoutConstraint *)heightConstraint {
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight && !constraint.secondItem && constraint.relation == NSLayoutRelationEqual && constraint.priority == UILayoutPriorityRequired) {
            return constraint;
        }
    }
    return nil;
}

- (void)layoutConstraintWithIdentifier:(NSString *)identifier constant:(CGFloat)constant {
    for (NSLayoutConstraint *constraint in self.constraints) {
        if ([constraint.identifier isEqualToString:identifier]) {
            constraint.constant = constant;
        }
    }
}

- (void)layoutConstraint:(NSLayoutAttribute)layoutAttribute secondItem:(UIView *)secondItem secondAttribute:(NSLayoutAttribute)secondAttribute offset:(CGFloat)offset {
    for (NSLayoutConstraint *constraint in self.superview.constraints) {
        if (constraint.firstItem == self && constraint.firstAttribute == layoutAttribute &&
            constraint.secondItem == secondItem && constraint.secondAttribute == secondAttribute) {
            constraint.constant = offset;
        }
    }
}
@end
