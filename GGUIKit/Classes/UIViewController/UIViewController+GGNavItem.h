//
//  UIViewController+NavItem.h
//  Beansmile
//
//  Created by John on 23/3/2017.
//

#import <UIKit/UIKit.h>
#import "GGUI.h"

@interface UIViewController (GGNavItem)

/**
 通过默认的图标设置返回事件，Item = [GGUISetting share].navigationItem.backItemImage
 在GGNavigationController中已经实现该默认方法 pop back
 @param action 返回事件
 */
- (void)gg_configNavigationBackAction:(indexBlock)action;

/**
 设置左 Item，以及对应的事件
 @param object Item 显示的元素，可以是 UIImage/NSString/UIButton，
 如果是 NSString，其 Font：[GGUISetting share].navigationItem.barItemFont，其 Color： [GGUISetting share].navigationItem.barItemTextColor
 通常 Font 和 Color 都是全局性一样的，如果需要特殊处理某个页面，可以传入 UIButton
 @param action 点击事件
 */
- (void)gg_configNavigationLeftItemWith:(id)object
                              andAction:(indexBlock)action;
/**
 设置右 Item，以及对应的事件
 @param object Item 显示的元素，可以是 UIImage/NSString/UIButton
 如果是 NSString，其 Font：[GGUISetting share].navigationItem.barItemFont，其 Color： [GGUISetting share].navigationItem.barItemTextColor
 通常 Font 和 Color 都是全局性一样的，如果需要特殊处理某个页面，可以传入 UIButton
 @param action 点击事件
 */
- (void)gg_configNavigationRightItemWith:(id)object
                               andAction:(indexBlock)action;

/**
 设置左边NavigationItem

 @param object 图片数组，最先添加进去为最左边
 @param spaceWidth 图片之间的间距，不设置的话为0
 @param action 通过indexBlock中的index判断是哪个图片，从左到右是1，2，3...
 */
- (void)gg_configNavigationLeftItemWithImages:(NSArray<UIImage *>*)object
                                   spaceWidth:(CGFloat)spaceWidth
                                    andAction:(indexBlock)action;

/**
 设置右边NavigationItem

 @param object 图片数组，最先添加进去为最右边
 @param spaceWidth 图片之间的间距，不设置的话为0
 @param action 通过indexBlock中的index判断是哪个图片，从右到左是1，2，3...
 */
- (void)gg_configNavigationRightItemWithImages:(NSArray<UIImage *>*)object
                                    spaceWidth:(CGFloat)spaceWidth
                                     andAction:(indexBlock)action;

- (void)gg_configNavigationLeftItems:(NSArray *)items spaceWidth:(CGFloat)spaceWidth;

- (void)gg_configNavigationRightItems:(NSArray *)items spaceWidth:(CGFloat)spaceWidth;

/**
 通过标题创建 UIButton
 */
- (UIButton *)gg_buttonWithTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color;

/**
 设置底部NavigationBar分割线
 */
- (void)gg_configNavigationBottomBorder:(BOOL)transparent;

/**适配iOS 15设置导航栏背景和文字*/
- (void)setNavigationColor:(UIColor *)backgroundColor titleTextAttributes:(NSDictionary *)attributes;
@end
