//
//  GGNumberTool.h
//  Beansmile
//
//  Created by John on 2017/11/1.
//

#import <Foundation/Foundation.h>

@interface GGNumberTool : NSObject

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
+ (CGSize)fixSizeBydisplayWidth:(CGFloat)displayWidth col:(NSInteger)col space:(CGFloat)space sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

+ (NSString *)numberStringWithFloatValue:(CGFloat)value;

@end
