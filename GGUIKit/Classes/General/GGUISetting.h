//
//  GGUISetting.h
//  AFNetworking
//
//  Created by John on 2019/4/29.
//

#import <Foundation/Foundation.h>

@interface GGImageDownloader : NSObject

@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, strong) UIColor *placeholderTintColor;
@property (nonatomic, strong) UIImage *avatarPlaceholderImage;
@property (nonatomic, strong) UIColor *avatarPlaceholderTintColor;
@property (nonatomic, strong) UIImage *failureImage;

@end

@interface GGNavigationItem : NSObject

@property (nonatomic, strong) UIImage *backItemImage;
@property (nonatomic, strong) UIFont *barItemFont;
@property (nonatomic, strong) UIColor *barItemTextColor;

@end

@interface GGUISetting : NSObject

+ (instancetype)share;

@property (nonatomic, strong) GGImageDownloader *imageDownloader;
@property (nonatomic, strong) GGNavigationItem *navigationItem;

@end
