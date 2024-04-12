//
//  UIImageView+GGWebCache.m
//  Beansmile
//
//  Created by John on 2018/7/6.
//

#import "UIImageView+GGWebCache.h"
#import "SDWebImage.h"

@implementation UIImageView (GGWebCache)

+ (void)clearImageCache{
    [[[SDWebImageManager sharedManager] imageCache] clearWithCacheType:SDImageCacheTypeDisk completion:^{

    }];
}

- (void)gg_setImageWithURLString:(NSString *)urlString {
    [self gg_setImageWithURLString:urlString placeholderImage:[GGUISetting share].imageDownloader.placeholderImage completed:nil];
}

- (void)gg_setImageWithURLString:(NSString *)urlString
                placeholderImage:(UIImage *)placeholderImage
                       completed:(SDExternalCompletionBlock)completedBlock{
    if (![urlString hasPrefix:@"http"] && urlString.length) {
        UIImage *image = [UIImage imageNamed:urlString];
        self.image = image ? image : placeholderImage;
    }else{
        NSURL *url = [NSURL URLWithString:urlString];
        [self sd_setImageWithURL:url placeholderImage:placeholderImage options:SDWebImageRetryFailed progress:nil completed:completedBlock];
    }
}

- (void)gg_setAvatarImageWithURLString:(NSString *)urlString{
    if (![urlString hasPrefix:@"http"] && urlString.length) {
        self.image = [UIImage imageNamed:urlString];
    }else{
        NSURL *url = [NSURL URLWithString:urlString];
        if (urlString && [[SDImageCache sharedImageCache] imageFromCacheForKey:[urlString stringByAppendingString:@"_avatar"]] ) {
            UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:[urlString stringByAppendingString:@"_avatar"]];
            self.image = image;
        }else{
            @weakify(self);
            [self sd_setImageWithURL:url
                    placeholderImage:[GGUISetting share].imageDownloader.avatarPlaceholderImage
                             options:SDWebImageRetryFailed
                           completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                               @strongify(self);
                               if (!image) {
                                   image = [GGUISetting share].imageDownloader.avatarPlaceholderImage;
                               }
                               CGFloat width = MIN(image.size.width, image.size.height);
                               UIImage *resizeimage = [image imageByResizeToSize:CGSizeMake(width, width) contentMode:UIViewContentModeScaleAspectFill];
                               UIImage *rounderImage = [resizeimage imageByRoundCornerRadius:width/2.0];
                               [[SDImageCache sharedImageCache] storeImage:rounderImage forKey:[url.absoluteString stringByAppendingString:@"_avatar"] completion:nil];
                               self.image = rounderImage;
                           }];
        }
    }
}

@end
