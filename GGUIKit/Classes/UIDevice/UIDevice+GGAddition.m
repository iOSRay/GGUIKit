//
//  UIDevice+GGAddition.m
//  Beansmile
//
//  Created by John on 2017/9/19.
//

#import "UIDevice+GGAddition.h"
@import AudioToolbox;
#import <sys/utsname.h>

@implementation UIDevice (GGAddition)

- (NSString *)hardwareIdentifier {
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

- (NSString *)hardwareName {
    NSString *identifier = self.hardwareIdentifier;
    return [UIDevice nameOfHardwareIdentifier: identifier] ?: identifier;
}

- (NSString *)hardwareLine {
    NSString *name = self.hardwareName;
    
    if ([name hasSuffix:@"Simulator"])
        return @"Simulator";
    
    if ([name hasPrefix:@"iPhone"]) {
        if ([name hasSuffix:@"Plus"])
            return @"iPhone Plus";
        return @"iPhone";
    }
    if ([name hasPrefix:@"iPad"]) {
        if ([name hasPrefix:@"iPad Air"])
            return @"iPad Air";
        if ([name hasPrefix:@"iPad Mini"])
            return @"iPad Mini";
        if ([name hasPrefix:@"iPad Pro"])
            return @"iPad Pro";
        return @"iPad";
    }
    if ([name hasPrefix:@"iPod Touch"] || [name hasPrefix:@"iPod"])
        return @"iPod Touch";
    if ([name hasPrefix:@"Apple TV"] || [name hasPrefix:@"AppleTV"])
        return @"Apple TV";
    
    return [NSString stringWithFormat:@"Unknown (%@)", name];
}

- (NSString *)hardwareFamily {
    NSString *name = self.hardwareName;
    
    if ([name hasSuffix:@"Simulator"])
        return @"Simulator";
    if ([name hasPrefix:@"iPhone"])
        return @"iPhone";
    if ([name hasPrefix:@"iPad"])
        return @"iPad";
    if ([name hasPrefix:@"iPod Touch"] || [name hasPrefix:@"iPod"])
        return @"iPod Touch";
    if ([name hasPrefix:@"Apple TV"] || [name hasPrefix:@"AppleTV"])
        return @"Apple TV";
    
    return [NSString stringWithFormat:@"Unknown (%@)", name];
}

- (NSUInteger)numberOfCores {
    return [[NSProcessInfo processInfo] processorCount];
}

- (BOOL)is64Bit {
    return sizeof(void *) >= 8; // Ready for 128-bit!
}

- (BOOL)iPhone {
    return (self.userInterfaceIdiom == UIUserInterfaceIdiomPhone);
}

- (BOOL)iPhoneX {
    UIScreen *screen = UIScreen.mainScreen;
    CGSize size = screen.fixedCoordinateSpace.bounds.size;
    return (self.iPhone && size.width == 375 && size.height == 812 && screen.scale == 3);
}

+ (BOOL)iPhoneXR{
    UIScreen *screen = UIScreen.mainScreen;
    CGSize size = screen.fixedCoordinateSpace.bounds.size;
    return (self.iPhone && size.width == 414 && size.height == 896 && screen.scale == 2);
}

+ (BOOL)iPhoneXS_Max{
    UIScreen *screen = UIScreen.mainScreen;
    CGSize size = screen.fixedCoordinateSpace.bounds.size;
    return (self.iPhone && size.width == 414 && size.height == 896 && screen.scale == 3);
}

+ (BOOL)iPhoneXSeries {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    
    return iPhoneXSeries;
}

- (BOOL)iPad {
    return (self.userInterfaceIdiom == UIUserInterfaceIdiomPad);
}

- (NSString *)idiomName {
    NSDictionary<NSNumber *, NSString *> *mapping = @{
                                                      @(UIUserInterfaceIdiomPhone): @"iphone",
                                                      @(UIUserInterfaceIdiomPad): @"ipad",
                                                      };
    return [mapping objectForKey:@(self.userInterfaceIdiom)];
}

- (NSString *)resourceSuffix {
    return [NSString stringWithFormat:@"~%@", self.idiomName];
}

- (NSString *)resource:(NSString *)string {
    return [string stringByAppendingString:self.resourceSuffix];
}

#pragma mark Actions

- (void)vibrate {
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}

#pragma mark Class Shorthands

+ (BOOL)iPhone {
    return self.currentDevice.iPhone;
}

+ (BOOL)iPhone_4{
    if ([UIScreen mainScreen].bounds.size.height == 480 && ![UIDevice iPhoneXSeries]){
        return YES;
    }
    return NO;
}

+ (BOOL)iPhone_5{
    if ([UIScreen mainScreen].bounds.size.height == 568 && ![UIDevice iPhoneXSeries]){
        return YES;
    }
    return NO;
}

+ (BOOL)iPhone_6{
    if ([UIScreen mainScreen].bounds.size.width == 375 && ![UIDevice iPhoneXSeries]) {
        return YES;
    }
    return NO;
}

+ (BOOL)iPhone_6_plus{
    if ([UIScreen mainScreen].bounds.size.width == 414 && ![UIDevice iPhoneXSeries]){
        return YES;
    }
    return NO;
}

+ (BOOL)iPhoneX {
    return self.currentDevice.iPhoneX;
}

+ (BOOL)iPad {
    return self.currentDevice.iPad;
}

+ (NSString *)idiomName {
    return self.currentDevice.idiomName;
}

+ (NSString *)resourceSuffix {
    return self.currentDevice.resourceSuffix;
}

+ (NSString *)resource:(NSString *)string {
    return [self.currentDevice resource:string];
}

+ (NSUInteger)numberOfCores {
    return self.currentDevice.numberOfCores;
}

+ (BOOL)is64Bit {
    return self.currentDevice.is64Bit;
}

+ (void)vibrate {
    [UIDevice.currentDevice vibrate];
}

+ (NSString *)nameOfHardwareIdentifier:(NSString *)identifier {
    static NSDictionary* names = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //! http://www.everyi.com/by-identifier/ipod-iphone-ipad-specs-by-model-identifier.html
        names = @{
                  //! Simulator
                  @"x86_64": @"Simulator",
                  @"i386": @"Simulator",
                  
                  //! iPhone
                  @"iPhone1,1": @"iPhone 1", //! 2007
                  
                  @"iPhone1,2": @"iPhone 3G", //! 2008
                  @"iPhone2,1": @"iPhone 3GS", //! 2009
                  
                  @"iPhone3,1": @"iPhone 4", //! GSM, 2010
                  @"iPhone3,2": @"iPhone 4", //! GSM, 2012
                  @"iPhone3,3": @"iPhone 4", //! CDMA, 2011
                  
                  @"iPhone4,1": @"iPhone 4S", //! 2011
                  
                  @"iPhone5,1": @"iPhone 5", //! GSM, 2012
                  @"iPhone5,2": @"iPhone 5", //! Global, 2012
                  @"iPhone5,3": @"iPhone 5C", //! GSM, 2013
                  @"iPhone5,4": @"iPhone 5C", //! Global, 2013
                  
                  @"iPhone6,1": @"iPhone 5S", //! GSM, 2013
                  @"iPhone6,2": @"iPhone 5S", //! Global, 2013
                  
                  @"iPhone7,1": @"iPhone 6 Plus", //! 2014
                  @"iPhone7,2": @"iPhone 6", //! 2014
                  
                  @"iPhone8,1": @"iPhone 6S", //! 2015
                  @"iPhone8,2": @"iPhone 6S Plus", //! 2015
                  
                  @"iPhone8,3": @"iPhone SE 1", //! 2016
                  @"iPhone8,4": @"iPhone SE 1", //! 2016
                  
                  @"iPhone9,1": @"iPhone 7", //! CDMA, 2016
                  @"iPhone9,2": @"iPhone 7 Plus", //! CDMA, 2016
                  @"iPhone9,3": @"iPhone 7", //! Global, 2016
                  @"iPhone9,4": @"iPhone 7 Plus", //! Global, 2016
                  
                  @"iPhone10,1": @"iPhone 8",
                  @"iPhone10,2": @"iPhone 8 Plus",
                  @"iPhone10,3": @"iPhone X",
                  @"iPhone10,4": @"iPhone 8",
                  @"iPhone10,5": @"iPhone 8 Plus",
                  @"iPhone10,6": @"iPhone X",
                  
                  @"iPhone11,2": @"iPhone XS",
                  @"iPhone11,4": @"iPhone XS Max",
                  @"iPhone11,6": @"iPhone XS Max CN",
                  @"iPhone11,8": @"iPhone XR",
                  
                  @"iPhone12,1": @"iPhone 11",
                  @"iPhone12,3": @"iPhone 11 Pro",
                  @"iPhone12,5": @"iPhone 11 Pro Max",
                  @"iPhone12,8": @"iPhone SE (2nd generation)",
                  
                  @"iPhone13,1": @"iPhone 12 mini",
                  @"iPhone13,2": @"iPhone 12",
                  @"iPhone13,3": @"iPhone 12 Pro",
                  @"iPhone13,4": @"iPhone 12 Pro Max",
                  
                  @"iPhone14,4": @"iPhone 13 mini",
                  @"iPhone14,5": @"iPhone 13",
                  @"iPhone14,2": @"iPhone 13 Pro",
                  @"iPhone14,3": @"iPhone 13 Pro Max",
                  
                  @"iPhone14,7": @"iPhone 14",
                  @"iPhone14,8": @"iPhone 14 Plus",
                  @"iPhone15,2": @"iPhone 14 Pro",
                  @"iPhone15,3": @"iPhone 14 Pro Max",
                  
                  //! iPod Touch
                  @"iPod1,1": @"iPod Touch 1", //! 2007
                  @"iPod2,1": @"iPod Touch 2", //! 2008
                  @"iPod3,1": @"iPod Touch 3", //! 2009
                  @"iPod4,1": @"iPod Touch 4", //! 2010
                  @"iPod5,1": @"iPod Touch 5", //! 2012
                  @"iPod7,1": @"iPod Touch 6", //! 2015
                  @"iPod9,1": @"iPod touch 7",
                  
                  //! iPad
                  @"iPad1,1": @"iPad 1", //! 2010
                  @"iPad1,2": @"iPad 1", //! Cellular, 2010
                  
                  @"iPad2,1": @"iPad 2", //! Wi-Fi, 2011
                  @"iPad2,2": @"iPad 2", //! GSM, 2011
                  @"iPad2,3": @"iPad 2", //! CDMA, 2011
                  @"iPad2,4": @"iPad 2", //! 2012
                  @"iPad2,5": @"iPad Mini 1", //! Wi-Fi, 2012
                  @"iPad2,6": @"iPad Mini 1", //! GSM, 2012
                  @"iPad2,7": @"iPad Mini 1", //! Global, 2012
                  
                  @"iPad3,1": @"iPad 3", //! Wi-Fi, 2012
                  @"iPad3,2": @"iPad 3", //! CDMA, 2012
                  @"iPad3,3": @"iPad 3", //! GSM, 2012
                  @"iPad3,4": @"iPad 4", //! Wi-Fi, 2012
                  @"iPad3,5": @"iPad 4", //! GSM, 2012
                  @"iPad3,6": @"iPad 4", //! Global, 2012
                  
                  @"iPad4,1": @"iPad Air 1", //! Wi-Fi, 2013
                  @"iPad4,2": @"iPad Air 1", //! Cellular, 2013
                  @"iPad4,3": @"iPad Air 1", //! China, 2013
                  @"iPad4,4": @"iPad Mini 2", //! Wi-Fi, 2013
                  @"iPad4,5": @"iPad Mini 2", //! Cellular, 2013
                  @"iPad4,6": @"iPad Mini 2", //! China, 2013
                  @"iPad4,7": @"iPad Mini 3", //! Wi-Fi, 2014
                  @"iPad4,8": @"iPad Mini 3", //! Cellular, 2014
                  
                  @"iPad5,1": @"iPad Mini 4", //! Wi-Fi, 2015
                  @"iPad5,2": @"iPad Mini 4", //! Cellular, 2015
                  @"iPad5,3": @"iPad Air 2", //! Wi-Fi, 2014
                  @"iPad5,4": @"iPad Air 2", //! Cellular, 2014
                  
                  @"iPad6,7": @"iPad Pro 12.9″ 1", //! Wi-Fi, 2015
                  @"iPad6,8": @"iPad Pro 12.9″ 1", //! Cellular, 2015
                  
                  @"iPad6,3": @"iPad Pro 9.7″ 1", //! Wi-Fi, 2016
                  @"iPad6,4": @"iPad Pro 9.7″ 1", //! Cellular, 2016
                  
                  @"iPad6,11": @"iPad 5", //! Wi-Fi, 2017
                  @"iPad6,12": @"iPad 5", //! Cellular, 2017
                  
                  @"iPad7,1": @"iPad Pro 12.9″ 2", //! Wi-Fi, 2017
                  @"iPad7,2": @"iPad Pro 12.9″ 2", //! Cellular, 2017
                  
                  @"iPad7,3": @"iPad Pro 10.5″ 1", //! Wi-Fi, 2017
                  @"iPad7,4": @"iPad Pro 10.5″ 1", //! Cellular, 2017
                  
                  @"iPad7,5": @"iPad 6 (WiFi)",
                  @"iPad7,6": @"iPad 6 (Cellular)",
                  
                  @"iPad7,11": @"iPad 7 (WiFi)",
                  @"iPad7,12": @"iPad 7 (Cellular)",
                  
                  @"iPad8,1" : @"iPad Pro (11 inch)",
                  @"iPad8,2" : @"iPad Pro (11 inch)",
                  @"iPad8,3" : @"iPad Pro (11 inch)",
                  @"iPad8,4" : @"iPad Pro (11 inch)",
                  
                  @"iPad8,5" : @"iPad Pro (12.9 inch, 3rd generation)",
                  @"iPad8,6" : @"iPad Pro (12.9 inch, 3rd generation)",
                  @"iPad8,7" : @"iPad Pro (12.9 inch, 3rd generation)",
                  @"iPad8,8" : @"iPad Pro (12.9 inch, 3rd generation)",
                  
                  @"iPad8,9" : @"iPad Pro (11 inch, 2nd generation)",
                  @"iPad8,10": @"iPad Pro (11 inch, 2nd generation)",
                  
                  @"iPad8,11": @"iPad Pro (12.9 inch, 4th generation)",
                  @"iPad8,12": @"iPad Pro (12.9 inch, 4th generation)",
                  
                  @"iPad11,1": @"iPad mini (5th generation)",
                  @"iPad11,2": @"iPad mini (5th generation)",
                  
                  @"iPad11,3": @"iPad Air (3rd generation)",
                  @"iPad11,4": @"iPad Air (3rd generation)",
                  
                  @"iPad11,6": @"iPad (WiFi)",
                  @"iPad11,7": @"iPad (Cellular)",
                  
                  @"iPad13,1": @"iPad Air (4th generation)",
                  @"iPad13,2": @"iPad Air (4th generation)",
                  
                  @"iPad13,4": @"iPad Pro (11 inch, 3rd generation)",
                  @"iPad13,5": @"iPad Pro (11 inch, 3rd generation)",
                  @"iPad13,6": @"iPad Pro (11 inch, 3rd generation)",
                  @"iPad13,7": @"iPad Pro (11 inch, 3rd generation)",
                  
                  @"iPad13,8": @"iPad Pro (12.9 inch, 5th generation)",
                  @"iPad13,9": @"iPad Pro (12.9 inch, 5th generation)",
                  
                  @"iPad13,10" : @"iPad Pro (12.9 inch, 5th generation)",
                  @"iPad13,11" : @"iPad Pro (12.9 inch, 5th generation)",
                  
                  @"iPad14,1" : @"iPad mini (6th generation)",
                  @"iPad14,2" : @"iPad mini (6th generation)",
                  
                  //! Apple Watch
                  @"Watch1,1" : @"Apple Watch 38mm",
                  @"Watch1,2" : @"Apple Watch 42mm",
                  @"Watch2,3" : @"Apple Watch Series 2 38mm",
                  @"Watch2,4" : @"Apple Watch Series 2 42mm",
                  @"Watch2,6" : @"Apple Watch Series 1 38mm",
                  @"Watch2,7" : @"Apple Watch Series 1 42mm",
                  @"Watch3,1" : @"Apple Watch Series 3 38mm",
                  @"Watch3,2" : @"Apple Watch Series 3 42mm",
                  @"Watch3,3" : @"Apple Watch Series 3 38mm (LTE)",
                  @"Watch3,4" : @"Apple Watch Series 3 42mm (LTE)",
                  @"Watch4,1" : @"Apple Watch Series 4 40mm",
                  @"Watch4,2" : @"Apple Watch Series 4 44mm",
                  @"Watch4,3" : @"Apple Watch Series 4 40mm (LTE)",
                  @"Watch4,4" : @"Apple Watch Series 4 44mm (LTE)",
                  @"Watch5,1" : @"Apple Watch Series 5 40mm",
                  @"Watch5,2" : @"Apple Watch Series 5 44mm",
                  @"Watch5,3" : @"Apple Watch Series 5 40mm (LTE)",
                  @"Watch5,4" : @"Apple Watch Series 5 44mm (LTE)",
                  @"Watch5,9" : @"Apple Watch SE 40mm",
                  @"Watch5,10" : @"Apple Watch SE 44mm",
                  @"Watch5,11" : @"Apple Watch SE 40mm",
                  @"Watch5,12" : @"Apple Watch SE 44mm",
                  @"Watch6,1"  : @"Apple Watch Series 6 40mm",
                  @"Watch6,2"  : @"Apple Watch Series 6 44mm",
                  @"Watch6,3"  : @"Apple Watch Series 6 40mm",
                  @"Watch6,4"  : @"Apple Watch Series 6 44mm",
                  
                  //! Apple HomePod
                  @"AudioAccessory1,1" : @"HomePod",
                  @"AudioAccessory1,2" : @"HomePod",
                  @"AudioAccessory5,1" : @"HomePod mini",
                  
                  //! Apple AirPods
                  @"AirPods1,1" : @"AirPods (1st generation)",
                  @"AirPods2,1" : @"AirPods (2nd generation)",
                  @"iProd8,1"   : @"AirPods Pro",
                  
                  //! Apple TV
                  @"AppleTV2,1": @"Apple TV 2", //! 2010
                  @"AppleTV3,1": @"Apple TV 3", //! 2012
                  @"AppleTV3,2": @"Apple TV 3", //! 2013
                  @"AppleTV5,3": @"Apple TV 4", //! 2015
                  @"AppleTV6,2": @"Apple TV 4K",
                  
                  };
    });
    return names[identifier];
}

@end
