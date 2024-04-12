//
//  UIViewController+GGNavItem.m
//  Beansmile
//
//  Created by John on 23/3/2017.
//

#import "UIViewController+GGNavItem.h"
#import <objc/runtime.h>

static id GGleftBlockKey;
static id GGrightBlockKey;

@implementation UIViewController (GGNavItem)

#pragma mark -------------------- Public --------------------

- (void)gg_configNavigationBackAction:(indexBlock)action{
    self.navigationItem.leftBarButtonItems = nil;
    [self gg_configNavigationLeftItemWith:[GGUISetting share].navigationItem.backItemImage andAction:action];
}

- (void)gg_configNavigationLeftItemWith:(id)object andAction:(indexBlock)action{
    self.navigationItem.leftBarButtonItems = nil;
    [self addNavigationItemWith:object isLeft:YES andAction:action];
}

- (void)gg_configNavigationRightItemWith:(id)object andAction:(indexBlock)action{
    self.navigationItem.rightBarButtonItems = nil;
    [self addNavigationItemWith:object isLeft:NO andAction:action];
}

- (void)gg_configNavigationLeftItemWithImages:(NSArray<UIImage *>*)object spaceWidth:(CGFloat)spaceWidth andAction:(indexBlock)action{
    self.navigationItem.leftBarButtonItems = nil;
    [self gg_configNavigationItemWithObjectArray:object isLeft:YES spaceWidth:spaceWidth andAction:action];
}

- (void)gg_configNavigationRightItemWithImages:(NSArray<UIImage *>*)object spaceWidth:(CGFloat)spaceWidth andAction:(indexBlock)action{
    self.navigationItem.rightBarButtonItems = nil;
    [self gg_configNavigationItemWithObjectArray:object isLeft:NO spaceWidth:spaceWidth andAction:action];
}

- (void)gg_configNavigationLeftItems:(NSArray *)items spaceWidth:(CGFloat)spaceWidth {
    self.navigationItem.leftBarButtonItems = nil;
    [self gg_configNavigationItems:items isLeft:YES spaceWidth:spaceWidth];
}

- (void)gg_configNavigationRightItems:(NSArray *)items spaceWidth:(CGFloat)spaceWidth {
    self.navigationItem.rightBarButtonItems = nil;
    [self gg_configNavigationItems:items isLeft:NO spaceWidth:spaceWidth];
}

- (void)gg_configNavigationBottomBorder:(BOOL)transparent {
    [self.navigationController.navigationBar.layer.sublayers enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.bounds.size.height < 1.0) {
            obj.hidden = transparent;
        }
    }];
}

#pragma mark -------------------- Private --------------------

- (void)gg_configNavigationItemWithObjectArray:(NSArray *)object isLeft:(BOOL)left spaceWidth:(CGFloat)spaceWidth andAction:(indexBlock)action{
    [object enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addNavigationItemWith:obj isLeft:left andAction:action];
        if (spaceWidth != 0 && idx != object.count - 1) {
            UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            space.width = spaceWidth;
            NSMutableArray *items;
            if (left) {
                items = [NSMutableArray arrayWithArray:self.navigationItem.leftBarButtonItems];
                [items addObject:space];
                [self.navigationItem setLeftBarButtonItems:items];
            }else{
                items = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
                [items addObject:space];
                [self.navigationItem setRightBarButtonItems:items];
            }
        }
    }];
}

- (void)gg_configNavigationItems:(NSArray *)object isLeft:(BOOL)left spaceWidth:(CGFloat)spaceWidth {
    [object enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addNavigationItemWith:obj isLeft:left andAction:nil];
        if (spaceWidth != 0 && idx != object.count - 1) {
            UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            space.width = spaceWidth;
            NSMutableArray *items;
            if (left) {
                items = [NSMutableArray arrayWithArray:self.navigationItem.leftBarButtonItems];
                [items addObject:space];
                [self.navigationItem setLeftBarButtonItems:items];
            }else{
                items = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
                [items addObject:space];
                [self.navigationItem setRightBarButtonItems:items];
            }
        }
    }];
}

- (void)addNavigationItemWith:(id)object isLeft:(BOOL)left andAction:(indexBlock)action{
    if (object) {
        NSCAssert([object isKindOfClass:[NSString class]] || [object isKindOfClass:[UIImage class]] || [object isKindOfClass:[UIButton class]], @"the object must be class of NSString or UIImage or UIButton");
        if ([object isKindOfClass:[UIImage class]]) {
            [self addNavigationItemImage:object isLeft:left andAction:action];
        }else if ([object isKindOfClass:[NSString class]]){
            [self addNavigationItemString:object isLeft:left andAction:action];
        }else if ([object isKindOfClass:[UIButton class]]) {
            [self addNavigationItemButton:object isLeft:left andAction:action];
        }
    }
}

- (void)addNavigationItemImage:(UIImage *)image isLeft:(BOOL)left andAction:(indexBlock)action{
    NSCAssert([image isKindOfClass:[UIImage class]], @"the text must be class of UIImage");
    if (action) {
        objc_setAssociatedObject(self, left ? &GGleftBlockKey : &GGrightBlockKey,
                                 action,
                                 OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    UINavigationItem *navItem = self.navigationItem;

    if (!image) {
        [navItem setRightBarButtonItem:nil];
        [navItem setRightBarButtonItems:nil];
    }else{
        if (left) {
            UIButton *btn = [self gg_buttonWithImage:image];
            btn.tag = navItem.leftBarButtonItems.count + 1;
            if (action) {
                [btn addTarget:self action:@selector(gg_pressLeft:) forControlEvents:UIControlEventTouchUpInside];
            }
            UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
            if (navItem.leftBarButtonItems.count>0) {
                NSMutableArray *items = [NSMutableArray arrayWithArray:navItem.leftBarButtonItems];
                [items addObject:barItem];
                [navItem setLeftBarButtonItems:items];
            }else {
                [navItem setLeftBarButtonItem:barItem];
            }
        }else {
            UIButton *btn = [self gg_buttonWithImage:image];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            btn.tag = navItem.rightBarButtonItems.count + 1;
            if (action) {
                [btn addTarget:self action:@selector(gg_pressRight:) forControlEvents:UIControlEventTouchUpInside];
            }
            UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
            if (navItem.rightBarButtonItems.count>0) {
                NSMutableArray *items = [NSMutableArray arrayWithArray:navItem.rightBarButtonItems];
                [items addObject:barItem];
                [navItem setRightBarButtonItems:items];
            }else {
                [navItem setRightBarButtonItem:barItem];
            }
        }
    }
}

- (void)addNavigationItemString:(NSString*)text isLeft:(BOOL)left andAction:(indexBlock)action{
    NSCAssert([text isKindOfClass:[NSString class]], @"the text must be class of NSString");
    if (action) {
        objc_setAssociatedObject(self, left ? &GGleftBlockKey : &GGrightBlockKey,
                                 action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    UINavigationItem *navItem = self.navigationItem;
    if (!text) {
        [navItem setRightBarButtonItem:nil];
        [navItem setRightBarButtonItems:nil];
    }else{
        if (left) {
            UIButton *btn = [self gg_buttonWithTitle:text];
            btn.tag = navItem.leftBarButtonItems.count + 1;
            if (action) {
                [btn addTarget:self action:@selector(gg_pressLeft:) forControlEvents:UIControlEventTouchUpInside];
            }
            UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:btn];

            if (navItem.leftBarButtonItems.count>0) {
                NSMutableArray *items = [NSMutableArray arrayWithArray:navItem.leftBarButtonItems];
                [items addObject:barItem];
                [navItem setLeftBarButtonItems:items];
            }else {
                [navItem setLeftBarButtonItem:barItem];
            }
        }else {
            UIButton *btn = [self gg_buttonWithTitle:text];;
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            btn.tag = navItem.rightBarButtonItems.count + 1;
            if (action) {
                [btn addTarget:self action:@selector(gg_pressRight:) forControlEvents:UIControlEventTouchUpInside];
            }
            UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
            barItem.tag = navItem.rightBarButtonItems.count + 1;
            if (navItem.rightBarButtonItems.count>0) {
                NSMutableArray *items = [NSMutableArray arrayWithArray:navItem.rightBarButtonItems];
                [items addObject:barItem];
                [navItem setRightBarButtonItems:items];
            }else {
                [navItem setRightBarButtonItem:barItem];
            }
        }
    }
}

- (void)addNavigationItemButton:(UIButton *)btn isLeft:(BOOL)left andAction:(indexBlock)action{
    NSCAssert([btn isKindOfClass:[UIButton class]], @"the text must be class of UIButton");

    if (action) {
        objc_setAssociatedObject(self, left ? &GGleftBlockKey : &GGrightBlockKey,
                                 action,
                                 OBJC_ASSOCIATION_COPY_NONATOMIC);
    }

    UINavigationItem *navItem = self.navigationItem;

    if (!btn) {
        [navItem setRightBarButtonItem:nil];
        [navItem setRightBarButtonItems:nil];
    }else{
        btn.height = 44;
        if (left) {
            btn.tag = navItem.leftBarButtonItems.count + 1;
            if (action) {
                [btn addTarget:self action:@selector(gg_pressLeft:) forControlEvents:UIControlEventTouchUpInside];
            }
            UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
            if (navItem.leftBarButtonItems.count>0) {
                NSMutableArray *items = [NSMutableArray arrayWithArray:navItem.leftBarButtonItems];
                [items addObject:barItem];
                [navItem setLeftBarButtonItems:items];
            }else {
                [navItem setLeftBarButtonItem:barItem];
            }
        }else {
            btn.tag = navItem.rightBarButtonItems.count + 1;
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            if (action) {
                [btn addTarget:self action:@selector(gg_pressRight:) forControlEvents:UIControlEventTouchUpInside];
            }
            UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
            barItem.tag = navItem.rightBarButtonItems.count + 1;
            if (navItem.rightBarButtonItems.count>0) {
                NSMutableArray *items = [NSMutableArray arrayWithArray:navItem.rightBarButtonItems];
                [items addObject:barItem];
                [navItem setRightBarButtonItems:items];
            }else {
                [navItem setRightBarButtonItem:barItem];
            }
        }
    }
}

- (UIButton *)gg_buttonWithTitle:(NSString *)title{
    return [self gg_buttonWithTitle:title font:[GGUISetting share].navigationItem.barItemFont color:[GGUISetting share].navigationItem.barItemTextColor];
}

- (UIButton *)gg_buttonWithTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color{
    UIButton *btn = [[UIButton alloc]init];
    [btn setContentEdgeInsets:UIEdgeInsetsMake(8, 0, 8, 8)];
    [btn setTitle:title forState:UIControlStateNormal];
    [[btn titleLabel]setFont:font];
    [btn setTitleColor:color forState:UIControlStateNormal];
    return btn;
}

- (UIButton *)gg_buttonWithImage:(UIImage *)image{
    UIButton *btn = [[UIButton alloc] init];
    btn.imageView.contentMode = UIViewContentModeCenter;
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 0);
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateHighlighted];
    
    [btn sizeToFit];
    if (btn.height < 28) {
        [btn setSize:CGSizeMake(38, 38)];
    }
    return btn;
}

#pragma mark -------------------- User Action ---------------------

- (void)gg_pressLeft:(UIButton *)sender{
    //从左到右 sender的tag值依次是1、2、3...
    indexBlock action = objc_getAssociatedObject(self, &GGleftBlockKey);
    if (action) {
        action(sender.tag);
    }
}

- (void)gg_pressRight:(UIButton *)sender{
    //从右到左 sender的tag值依次是1、2、3...
    indexBlock action = objc_getAssociatedObject(self, &GGrightBlockKey);
    if (action) {
        action(sender.tag);
    }
}

- (void)setNavigationColor:(UIColor *)backgroundColor titleTextAttributes:(NSDictionary *)attributes {
    if (@available(iOS 15.0, *)) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:backgroundColor] forBarMetrics:UIBarMetricsDefault];
        UINavigationBarAppearance *barApp = [UINavigationBarAppearance new];
        barApp.backgroundColor = backgroundColor;
        barApp.titleTextAttributes = attributes;
        self.navigationController.navigationBar.scrollEdgeAppearance = barApp;
        self.navigationController.navigationBar.standardAppearance = barApp;
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:backgroundColor] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    }
}

@end
