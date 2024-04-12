//
//  YYCache+Addition.m
//  Beansmile
//
//  Created by John on 16/1/16.
//
//

#import "YYCache+Addition.h"
#import "YYDiskCache.h"
#import "YYMemoryCache.h"

NSString *const kshareCacheName = @"com.beansmile.cache";

@implementation YYCache (Addition)

+ (YYCache*)shareCache{
    YYCache *cache = [YYCache cacheWithName:kshareCacheName];
    return cache;
}

+ (YYDiskCache*)yzDiskCacheWithName:(NSString *)name{
    NSString *basePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject];
    YYDiskCache *yy = [[YYDiskCache alloc] initWithPath:[basePath stringByAppendingPathComponent:name]];
    return yy;
}

+ (YYMemoryCache*)yzMemoryCache{
    static YYMemoryCache *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [YYMemoryCache new];
        cache.releaseOnMainThread = YES;
        cache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    });
    return cache;
}

@end
