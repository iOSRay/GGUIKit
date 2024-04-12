//
//  YYFPSLabel+Initial.m
//  Beansmile
//
//  Created by John on 17/12/2016.
//
//

#import "YYFPSLabel+Initial.h"
#import "YYKit.h"

@implementation YYFPSLabel (Initial)

#ifdef DEBUG
+ (void)load {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        YYFPSLabel *label = [[YYFPSLabel alloc] init];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        label.frame = (CGRect){CGPointMake(1, window.height - label.size.height - kTabBarHeight), label.size};
        [window addSubview:label];
    });
}
#endif

@end
