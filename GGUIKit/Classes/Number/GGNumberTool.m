//
//  GGNumberTool.m
//  Beansmile
//
//  Created by John on 2017/11/1.
//

#import "GGNumberTool.h"

@implementation GGNumberTool

+ (CGSize)fixSizeBydisplayWidth:(CGFloat)displayWidth col:(NSInteger)col space:(CGFloat)space sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    float pxWidth = displayWidth * [UIScreen mainScreen].scale;
    pxWidth = pxWidth - space * [UIScreen mainScreen].scale * (col - 1);
    int mo = (int)pxWidth % col;
    if (mo != 0) {
        // 屏幕宽度不可以平均分配
        float fixPxWidth = pxWidth - mo;
        float itemWidth = fixPxWidth / col;
        // 高度取最高的，所以要加1
        float itemHeight = itemWidth + 1.0;
        if (indexPath.row % col < mo) {
            // 模再分配给左边的cell，直到分配完为止
            itemWidth = itemWidth + 1.0;
        }
        NSNumber *numW = @(itemWidth / [UIScreen mainScreen].scale);
        NSNumber *numH = @(itemHeight / [UIScreen mainScreen].scale);
        return CGSizeMake(numW.floatValue, numH.floatValue);
    }else {
        // 屏幕可以平均分配
        float itemWidth = pxWidth / col;
        return CGSizeMake(itemWidth / [UIScreen mainScreen].scale, itemWidth / [UIScreen mainScreen].scale);
    }
}

+ (NSString *)numberStringWithFloatValue:(CGFloat)value{
    CGFloat conversionValue = ceil(value * 100)/100;
    NSString *doubleString = [NSString stringWithFormat:@"%.2f", conversionValue];
    return doubleString;
}

@end
