//
//  GGUISetting.m
//  AFNetworking
//
//  Created by John on 2019/4/29.
//

#import "GGUISetting.h"

@implementation GGImageDownloader
@end


@implementation GGNavigationItem
@end


@implementation GGUISetting

+ (instancetype)share{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

GGLazyAddObject(GGImageDownloader, imageDownloader)
GGLazyAddObject(GGNavigationItem, navigationItem)

@end
