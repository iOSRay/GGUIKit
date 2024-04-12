//
//  GGSizeTool.m
//  Beansmile
//
//  Created by John on 2018/10/11.
//

#import "GGSizeTool.h"

@implementation GGSizeTool

+ (CGFloat)labelWidthByText:(NSString *)text font:(UIFont *)font {
    UILabel *label = [UILabel new];
    label.font = font;
    label.text = text;
    CGFloat width = [label sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    label = nil;
    return width;
}

+ (CGFloat)labelHeightByText:(NSString *)text font:(UIFont *)font fitWidth:(CGFloat)width{
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.font = font;
    label.text = text;
    CGFloat labelHeight = [label sizeThatFits:CGSizeMake(width, MAXFLOAT)].height;
    label = nil;
    return labelHeight;
}

+ (CGSize)imagelayoutSizeBySize:(CGSize)originSize {
    CGSize bubbleSize = originSize;
    
    CGFloat imageViewW = bubbleSize.width;
    CGFloat imageViewH = bubbleSize.height;
    
    CGFloat maxWidth = imageViewW>imageViewH? SCREEN_WIDTH * 0.5:SCREEN_HEIGHT * 0.25;//限制最大宽度
    
    CGFloat factor = 1.0f;
    
    if(imageViewW > imageViewH){
        factor = maxWidth/imageViewW;
    }else {
        factor = maxWidth/imageViewH;
    }
    imageViewW = imageViewW * factor;
    imageViewH = imageViewH * factor;
    bubbleSize = CGSizeMake(imageViewW, imageViewH);
    return bubbleSize;
}

+ (CGSize)fixSizeBydisplayWidth:(float)displayWidth col:(int)col space:(int)space sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
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

+ (CGSize)getScaleRect:(CGSize)originSize targetSize:(CGSize)maxSize{
    CGFloat width=originSize.width;
    CGFloat height=originSize.height;

    CGFloat wSize=width/maxSize.width;
    CGFloat hSize=height/maxSize.height;

    CGFloat currSize= wSize > hSize ? wSize : hSize;

    CGFloat finelWidth=width/currSize;
    CGFloat finelHeight=height/currSize;

    return CGSizeMake(finelWidth, finelHeight);
}

@end
