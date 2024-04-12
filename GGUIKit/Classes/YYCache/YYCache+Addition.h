//
//  YYCache+Addition.h
//  Beansmile
//
//  Created by John on 16/1/16.
//
//

#import <YYKit/YYCache.h>

@interface YYCache (Addition)

+ (YYCache*)shareCache;

+ (YYDiskCache*)yzDiskCacheWithName:(NSString *)name;

+ (YYMemoryCache*)yzMemoryCache;

@end
