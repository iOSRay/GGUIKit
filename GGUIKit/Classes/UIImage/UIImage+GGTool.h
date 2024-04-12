//
//  UIImage+GGTool.h
//  Beansmile
//
//  Created by John on 2017/9/11.
//

#import <UIKit/UIKit.h>

@interface UIImage (GGTool)

- (UIImage*)scaleToSize:(CGSize)size;

- (UIImage *)imageByTintColor:(UIColor *)color;

- (UIImage *)imageWithHue:(CGFloat)hue
               saturation:(CGFloat)saturation
               brightness:(CGFloat)brightness
                    alpha:(CGFloat)alpha;

/**
 添加水印
 @param waterImage 水印图片
 @return 处理好的图片
 */
- (UIImage *)gg_waterImageWithImage:(UIImage *)waterImage;

/**
 高斯模糊，建议在后台线程调用该方法
 @param blur 模糊度，越大越模糊
 @return 模糊后的图片
 */
- (UIImage*)gg_boxblurImageWithBlur:(CGFloat)blur;

@end
