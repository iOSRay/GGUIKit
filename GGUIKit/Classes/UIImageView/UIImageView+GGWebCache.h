//
//  UIImageView+GGWebCache.h
//  Beansmile
//
//  Created by John on 2018/7/6.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface UIImageView (GGWebCache)

/**
 清除图片缓存
 */
+ (void)clearImageCache;

/**
 设置图片
 @param urlString web url，如果没有识别出 http，则会用本地图片去设置
 */
- (void)gg_setImageWithURLString:(NSString *)urlString;

/**
 设置图片
 @param urlString urlString web url，如果没有识别出 http，则会用本地图片去设置
 @param placeholderImage 占位图
 @param completedBlock 完成回调
 */
- (void)gg_setImageWithURLString:(NSString *)urlString
                placeholderImage:(UIImage *)placeholderImage
                       completed:(SDExternalCompletionBlock)completedBlock;

/**
 设置头像图片，会自动设置好圆角图片并缓存
 @param urlString web url，如果没有识别出 http，则会用本地图片去设置
 */
- (void)gg_setAvatarImageWithURLString:(NSString *)urlString;

@end
