//
//  NavHeightConstraint.m
//  AFNetworking
//
//  Created by John on 2019/4/28.
//

#import "NavHeightConstraint.h"
#import "GGGlobals.h"

@implementation NavHeightConstraint

- (void)setConstant:(CGFloat)constant{
    super.constant = constant;
}

- (CGFloat)constant {
    return kNavigationBarHeight;
}

@end
