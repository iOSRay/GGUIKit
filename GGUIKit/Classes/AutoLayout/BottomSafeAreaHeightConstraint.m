//
//  BottomSafeAreaHeightConstraint.m
//  AFNetworking
//
//  Created by John on 2019/4/28.
//

#import "BottomSafeAreaHeightConstraint.h"
#import "GGGlobals.h"

@implementation BottomSafeAreaHeightConstraint

- (void)setConstant:(CGFloat)constant{
    super.constant = constant;
}

- (CGFloat)constant {
    return kBottomAdditionHeight;
}

@end
