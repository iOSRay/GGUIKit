//
//  GGStringTool.h
//  Beansmile
//
//  Created by John on 8/30/16.
//

#import <Foundation/Foundation.h>
#import "NSString+RemoveEmoji.h"

@interface GGStringTool : NSObject

+ (NSString *)translationArabicNum:(NSInteger)arabicNum;

+ (BOOL)isValidateChineseString:(NSString *)string;

+ (NSInteger)oneChineseEqualTwoEnglishLengthWithValidateStr:(NSString *)str;

+ (NSInteger)lengthWithValidateStr:(NSString *)str;

+ (NSString *)oneChineseEqualTwoEnglishCutStringToLen:(NSInteger)len withStr:(NSString *)str;

+ (NSString *)normalCutStringToLen:(NSInteger)len withStr:(NSString *)str;

+ (BOOL)stringContainsEmoji:(NSString *)string;

+ (BOOL)stringIsEmpty:(NSString *) aString;

+ (BOOL)stringIsEmpty:(NSString *) aString shouldCleanWhiteSpace:(BOOL)cleanWhileSpace;

+ (NSString *)limitString:(NSString *)string withLength:(unsigned short)length;

+ (BOOL)isValidateEmail:(NSString *)email;

+ (BOOL)isValidateMobile:(NSString *)mobile;

+ (BOOL)isValidZipcode:(NSString*)value;

+ (void)checkURLForString:(NSString *)str completionHandler:(boolBlock)resultHandler;

@end
