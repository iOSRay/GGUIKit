//
//  GGGlobals.h
//  Beansmile
//
//  Created by John on 1/5/15.
//

#import <UIKit/UIKit.h>
#import "UIDevice+GGAddition.h"

#define STRING_OR_EMPTY(A)               ({ __typeof__(A) __a = (A); __a ? __a : @""; })
#define NUMBER_OR_EMPTY(A)               ({ __typeof__(A) __a = (A); __a.boolValue ? __a : @(0); })
#define NUMBER_WITH_STRING(A)            ([NSString stringWithFormat:@"%@", @(A)])
#define kString(A)                       ([NSString stringWithFormat:@"%@", A])
#define kCurrentWindow                   [[UIApplication sharedApplication].windows firstObject]

#define SCREEN_WIDTH                     MIN([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)
#define SCREEN_HEIGHT                    MAX([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)
#define kStatusBarHeight                 getTopStatusBarHeight()
#define kBottomAdditionHeight            getBottomSafeAreaHeight()
#define kNavigationBarHeight             (44 + kStatusBarHeight)
#define kTabBarHeight                    (49 + kBottomAdditionHeight)
#define kValue(val)                      ((val) * (SCREEN_WIDTH / 375.0))

static CGFloat topStatusBarHeight = -1;
CG_INLINE CGFloat getTopStatusBarHeight() {
    if (topStatusBarHeight < 0) {
        if (@available(iOS 11, *)) {
            CGFloat top = [UIApplication sharedApplication].delegate.window.safeAreaInsets.top;
            topStatusBarHeight = top > 0 ? top: 20;
        }else{
            topStatusBarHeight = 20.0;
        }
    }
    return topStatusBarHeight;
}

static CGFloat bottomSafeAreaHeight = -1;
CG_INLINE CGFloat getBottomSafeAreaHeight() {
    if (bottomSafeAreaHeight < 0) {
        if (@available(iOS 11, *)) {
            CGFloat bottom = [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom;
            bottomSafeAreaHeight = bottom > 0 ? bottom : 0;
        }else{
            bottomSafeAreaHeight = 0;
        }
    }
    return bottomSafeAreaHeight;
}

static void *gg_setViewModelKey;
#define GG_AssociatedViewModel                          objc_setAssociatedObject(self, gg_setViewModelKey, viewModel, OBJC_ASSOCIATION_RETAIN);

//#ifdef DEBUG
//#   define DLog(fmt, ...) NSLog((@"😋%s Line %d ------- \n " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
//#else
//#   define DLog(...)
//#endif

#define GGLazyAddObject(_type_, _ivar_) \
- (_type_ *)_ivar_ { \
if (! _##_ivar_) { \
_##_ivar_ = [[_type_ alloc] init]; \
} \
return _##_ivar_; \
}

#define GGLazyAddView(_type_, _ivar_) \
- (_type_ *)_ivar_ { \
if (! _##_ivar_) { \
_##_ivar_ = [_type_ loadFromNib]; \
} \
return _##_ivar_; \
}

#define GGLazyCreateViewController(_type_, _ivar_) \
- (_type_ *)_ivar_ { \
if (! _##_ivar_) { \
_##_ivar_ = [_type_ create]; \
} \
return _##_ivar_; \
}


//Block
typedef void(^voidBlock)(void);
typedef void(^stringBlock)(NSString *result);
typedef void(^boolBlock)(BOOL boolen);
typedef void(^indexBlock)(NSInteger index);
typedef void(^errorBlock)(NSError *error);
typedef void(^numberBlock)(NSNumber *result);
typedef void(^arrayWithErrorBlock)(NSArray *results,NSError *error);
typedef void(^arrayBlock)(NSArray *results);
typedef void(^objectBlock)(id obj);
