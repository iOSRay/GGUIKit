//
//  GGSizeTool.h
//  Beansmile
//
//  Created by John on 2018/10/11.
//

#import <Foundation/Foundation.h>

@interface GGSizeTool : NSObject

+ (CGFloat)labelWidthByText:(NSString *)text font:(UIFont *)font;
+ (CGFloat)labelHeightByText:(NSString *)text font:(UIFont *)font fitWidth:(CGFloat)width;

+ (CGSize)imagelayoutSizeBySize:(CGSize)originSize;

/**
 *  @brief 取模之后再分配多余的像素，去除平分cell的缝隙.
 *
 *  @param displayWidth  显示的宽度范围（一般是屏幕宽度）
 *  @param col 显示的列数
 *  @param space 列间隔宽度（可以在这里设置，也可以在collection的回调函数中设置）
 *  @param indexPath cell的indexPath
 *
 *  @return 本cell的size
 *
 *  iPhone 6的屏幕是 750.
 *  col = 4，space = 0；
 *  750 % 4 = 2；
 *  (750 - 2) = 187;
 *  每一行的结果
 *  [188,188,187,187];
 *
 */
+ (CGSize)fixSizeBydisplayWidth:(float)displayWidth col:(int)col space:(int)space sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

+ (CGSize)getScaleRect:(CGSize)originSize targetSize:(CGSize)maxSize;

@end
