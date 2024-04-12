//
//  GGStringTool.m
//  Beansmile
//
//  Created by John on 8/30/16.
//

#import "GGStringTool.h"

@implementation GGStringTool

+ (NSString *)translationArabicNum:(NSInteger)arabicNum{
    NSString *arabicNumStr = [NSString stringWithFormat:@"%ld",(long)arabicNum];
    NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chineseNumeralsArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chineseNumeralsArray forKeys:arabicNumeralsArray];
    
    if (arabicNum < 20 && arabicNum > 9) {
        if (arabicNum == 10) {
            return @"十";
        }else{
            NSString *subStr1 = [arabicNumStr substringWithRange:NSMakeRange(1, 1)];
            NSString *a1 = [dictionary objectForKey:subStr1];
            NSString *chinese1 = [NSString stringWithFormat:@"十%@",a1];
            return chinese1;
        }
    }else{
        NSMutableArray *sums = [NSMutableArray array];
        for (int i = 0; i < arabicNumStr.length; i ++){
            NSString *substr = [arabicNumStr substringWithRange:NSMakeRange(i, 1)];
            NSString *a = [dictionary objectForKey:substr];
            NSString *b = digits[arabicNumStr.length -i-1];
            NSString *sum = [a stringByAppendingString:b];
            if ([a isEqualToString:chineseNumeralsArray[9]]){
                if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]]){
                    sum = b;
                    if ([[sums lastObject] isEqualToString:chineseNumeralsArray[9]]){
                        [sums removeLastObject];
                    }
                }else{
                    sum = chineseNumeralsArray[9];
                }
                if ([[sums lastObject] isEqualToString:sum]){
                    continue;
                }
            }
            [sums addObject:sum];
        }
        NSString *sumStr = [sums  componentsJoinedByString:@""];
        NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
        return chinese;
    }
}

+ (BOOL)isValidateChineseString:(NSString *)string {
    NSString *chineseRegex = @"^[\u4e00-\u9fa5]";
    NSPredicate *chineseTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chineseRegex];
    return [chineseTest evaluateWithObject:string];
}

+ (NSInteger)oneChineseEqualTwoEnglishLengthWithValidateStr:(NSString *)str{
    __block NSInteger length = 0;
    
    [str enumerateSubstringsInRange:NSMakeRange(0, str.length)
                            options:NSStringEnumerationByComposedCharacterSequences
                         usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        length += (([self isValidateChineseString:substring] || [substring isEmoji]) ?1:1);
        if (substring.length == 0) {
            *stop = YES;
        }
    }];
    return length;
}

+ (NSInteger)lengthWithValidateStr:(NSString *)str{
    __block NSInteger length = 0;
    [str enumerateSubstringsInRange:NSMakeRange(0, str.length)
                            options:NSStringEnumerationByComposedCharacterSequences
                         usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        //将所有emoji当成和中文一样两个字符
        length += (([self isValidateChineseString:substring] || [substring isEmoji]) ?2:1);
        if (substring.length == 0) {
            *stop = YES;
        }
    }];
    return length;
}

+ (NSString *)oneChineseEqualTwoEnglishCutStringToLen:(NSInteger)len withStr:(NSString *)str{
    __block NSInteger count = 0;
    __block NSInteger idx = 0;
    __block NSInteger index = len;
    __block NSMutableString *string = [@"" mutableCopy];
    [str enumerateSubstringsInRange:NSMakeRange(0, str.length)
                            options:NSStringEnumerationByComposedCharacterSequences
                         usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                             count += (([self isValidateChineseString:substring]|| [substring isEmoji]) ?2:1);
                             [string appendString:substring];
                             idx += 1;
                             if (count>=len*2) {
                                 index = idx;
                                 *stop = YES;
                             }
                         }];
    return string;
}

+ (NSString *)normalCutStringToLen:(NSInteger)len withStr:(NSString *)str{
    __block NSInteger count = 0;
    __block NSInteger idx = 0;
    __block NSInteger index = len;
    __block NSMutableString *string = [@"" mutableCopy];
    [str enumerateSubstringsInRange:NSMakeRange(0, str.length)
                            options:NSStringEnumerationByComposedCharacterSequences
                         usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                             count += (([self isValidateChineseString:substring]|| [substring isEmoji]) ?1:1);
                             [string appendString:substring];
                             idx += 1;
                             if (count>=len) {
                                 index = idx;
                                 *stop = YES;
                             }
                         }];
    return string;
}

+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    return returnValue;
}

#pragma mark String
+ (BOOL)stringIsEmpty:(NSString *) aString {

    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }

    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    } else {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }

    return NO;
}

+ (BOOL)stringIsEmpty:(NSString *) aString shouldCleanWhiteSpace:(BOOL)cleanWhileSpace {
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }

    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    }

    if (cleanWhileSpace) {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }

    return NO;
}

#pragma mark -
#pragma mark Text

+ (NSString *)limitString:(NSString *)string withLength:(unsigned short)length{
    NSString* returnString=string;
    if([string length]>length) {
        returnString=[NSString stringWithFormat:@"%@...",[string substringToIndex:length-3]];
    }
    return returnString;
}

+ (BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isValidateMobile:(NSString *)mobile{
    if (mobile.length != 11) {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,108,147,178,1705
     */

    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478]|9[8])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom      * 130,131,132,155,156,166,185,186,145,176,1709
     */

    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|56[6]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,199,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019]|9[9])\\d{8}$)|(^1700\\d{7}$)";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobile] == YES)
        || ([regextestcm evaluateWithObject:mobile] == YES)
        || ([regextestct evaluateWithObject:mobile] == YES)
        || ([regextestcu evaluateWithObject:mobile] == YES))
    {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isValidZipcode:(NSString*)value{
    const char *cvalue = [value UTF8String];
    NSInteger len = strlen(cvalue);
    if (len != 6) {
        return NO;
    }
    for (int i = 0; i < len; i++)
    {
        if (!(cvalue[i] >= '0' && cvalue[i] <= '9'))
        {
            return NO;
        }
    }
    return YES;
}


+ (void)checkURLForString:(NSString *)str completionHandler:(boolBlock)resultHandler{
    NSURL *     result;
    NSString *  trimmedStr;
    NSRange     schemeMarkerRange;
    NSString *  scheme;

    assert(str != nil);
    result = nil;

    trimmedStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( (trimmedStr != nil) && (trimmedStr.length != 0) ) {
        schemeMarkerRange = [trimmedStr rangeOfString:@"://"];
        if (schemeMarkerRange.location == NSNotFound) {
            result = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", trimmedStr]];
        } else {
            scheme = [trimmedStr substringWithRange:NSMakeRange(0, schemeMarkerRange.location)];
            assert(scheme != nil);
            if ( ([scheme compare:@"http"  options:NSCaseInsensitiveSearch] == NSOrderedSame)
                || ([scheme compare:@"https" options:NSCaseInsensitiveSearch] == NSOrderedSame) ) {
                result = [NSURL URLWithString:trimmedStr];
            }
        }
    }

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:result];
    [request setHTTPMethod:@"HEAD"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"error %@",error);
        if (error) {
            if (resultHandler) {
                resultHandler(NO);
            }
        }else{
            if (resultHandler) {
                resultHandler(YES);
            }
        }
    }];
    [task resume];
}


@end
