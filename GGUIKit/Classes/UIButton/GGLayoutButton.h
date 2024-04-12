//
//  GGLayoutButton.h
//  Beansmile
//
//  Created by John on 17/4/13.
//
// 自定义的按钮，主要用于图片文字布局

#import <UIKit/UIKit.h>

/*

 //LayoutButtonStyleLeftImageRightTitle
 +-----------+
 |           |
 |(Image)Text|
 |           |
 |           |
 +-----------+
 
 //LayoutButtonStyleLeftTitleRightImage
 +-----------+
 |           |
 |Text(Image)|
 |           |
 |           |
 +-----------+
 
 //LayoutButtonStyleUpImageDownTitle
 +-----------+
 |           |
 |  (Image)  |
 |   Text    |
 |           |
 +-----------+
 
 //LayoutButtonStyleUpTitleDownImage
 +-----------+
 |           |
 |   Text    |
 |  (Image)  |
 |           |
 +-----------+
 
 */

typedef NS_ENUM(NSUInteger, LayoutButtonStyle) {
    LayoutButtonStyleLeftImageRightTitle,
    LayoutButtonStyleLeftTitleRightImage,
    LayoutButtonStyleUpImageDownTitle,
    LayoutButtonStyleUpTitleDownImage
};

/// 重写layoutSubviews的方式实现布局，忽略imageEdgeInsets、titleEdgeInsets和contentEdgeInsets
@interface GGLayoutButton : UIButton

@property (nonatomic, assign) IBInspectable NSInteger layoutStyleNumber;

/// 布局方式
@property (nonatomic, assign) LayoutButtonStyle layoutStyle;
/// 图片和文字的间距，默认值8
@property (nonatomic, assign) IBInspectable CGFloat midSpacing;
/// 指定图片size
@property (nonatomic, assign) IBInspectable CGSize imageSize;

@end
