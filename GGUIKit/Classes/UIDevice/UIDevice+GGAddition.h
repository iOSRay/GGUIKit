//
//  UIDevice+GGAddition.h
//  Beansmile
//
//  Created by John on 2017/9/19.
//

#import <UIKit/UIKit.h>

#define CurrentAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface UIDevice (GGAddition)

/// Returns hardware identifier. Example: iPad5,2
- (NSString *)hardwareIdentifier;

/// Returns human-readable hardware name. Example: iPad Mini 4
- (NSString *)hardwareName;

/// Returns hardware line of products. Example: iPad Mini
- (NSString *)hardwareLine;

/// Returns hardware family of products. Example: iPad
- (NSString *)hardwareFamily;

/// Returns the number of CPU cores of the device.
- (NSUInteger)numberOfCores;

/// Returns YES only if size of pointer is at least 8 bytes. This means that your app needs to be 64-bit too.
- (BOOL)is64Bit;

#pragma mark Actions

/// Vibrates the device for short time.
- (void)vibrate;

#pragma mark - Idiom

/// Return YES on when idiom is Phone.
- (BOOL)iPhone;

+ (BOOL)iPhone_4;

+ (BOOL)iPhone_5;

+ (BOOL)iPhone_6;

+ (BOOL)iPhone_6_plus;

/// Returns YES, if the device has features of iPhone X.
+ (BOOL)iPhoneX;

+ (BOOL)iPhoneXR;

+ (BOOL)iPhoneXS_Max;

+ (BOOL)iPhoneXSeries;

/// Return YES on when idiom is Pad.
- (BOOL)iPad;

/// Returns the name of current idiom. Example: "iphone".
- (NSString *)idiomName;

/// Returns string used to identify resources on for current idiom. Example: "~iphone".
- (NSString *)resourceSuffix;

/// Returns resource string by appending resource suffix.
- (NSString *)resource:(NSString *)string;

#pragma mark Class Shorthands

/// These methods call corresponding instance methods on [UIDevice currentDevice] object.

+ (BOOL)iPhone;
+ (BOOL)iPad;
+ (NSString *)idiomName;
+ (NSString *)resourceSuffix;
+ (NSString *)resource:(NSString *)string;
+ (NSUInteger)numberOfCores;
+ (BOOL)is64Bit;
+ (void)vibrate;

@end
