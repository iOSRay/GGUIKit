//
//  NSString+Addition.h
//  Beansmile
//
//  Created by John on 16/5/4.
//

#import <Foundation/Foundation.h>

@interface NSString (Addition)

- (BOOL)isValidateMobile;

- (NSString *)ebg13String;

- (NSString *)reverseString;

+ (NSString *)infoByKey:(NSString *)key NeedEbg:(BOOL)need;

@end
