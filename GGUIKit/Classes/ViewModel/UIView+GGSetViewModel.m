//
//  UIView+GGSetViewModel.m
//  Beansmile
//
//  Created by John on 2018/4/26.
//

#import "UIView+GGSetViewModel.h"

@implementation UIView (GGSetViewModel)

- (void)setViewModel:(GGViewModel *)viewModel {
    GG_AssociatedViewModel
}

- (GGViewModel *)viewModel {
    return objc_getAssociatedObject(self, gg_setViewModelKey);
}

@end
