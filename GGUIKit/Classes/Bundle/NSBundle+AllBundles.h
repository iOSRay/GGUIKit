//
//  NSBundle+AllBundles.h
//
//  Created by John on 16/4/18.
//
//

#import <Foundation/Foundation.h>

@interface NSBundle (AllBundles)

+ (NSArray*)allAppBundles;

+ (NSString*)bundlsPathForResource:(NSString*)resource ofType:(NSString *)type;

@end
