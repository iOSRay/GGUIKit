//
//  NSBundle+AllBundles.m
//
//  Created by John on 16/4/18.
//
//

#import "NSBundle+AllBundles.h"

@implementation NSBundle (AllBundles)

+ (NSArray*)allAppBundles{
    static NSArray *_bundles = nil;
    if (!_bundles) {
        NSArray *bundlesPaths = [[NSBundle mainBundle] pathsForResourcesOfType:@"bundle"
                                                                   inDirectory:@"."];
        NSMutableArray *bundles = [NSMutableArray array];
        [bundlesPaths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [bundles addObject:[NSBundle bundleWithPath:obj]];
        }];
        _bundles = [@[[NSBundle mainBundle]] arrayByAddingObjectsFromArray:bundles];
    }
    return _bundles;
}

+ (NSString*)bundlsPathForResource:(NSString*)resource ofType:(NSString *)type{
    __block NSString *path;
    [[self allAppBundles]enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        path = [obj pathForResource:resource ofType:type];
        if (path) {
            *stop = YES;
        }
    }];
    return path;
}

@end
