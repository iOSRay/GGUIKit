//
//  GGUtil.m
//  VisibleTools
//
//  Created by gump on 11-5-13.
//  Copyright 2011年 f4 . All rights reserved.
//

#import "GGUtil.h"
#import <objc/runtime.h>

@import MessageUI;
@import SystemConfiguration;
@import Darwin;

@implementation GGUtil

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    NSError *error = nil;
    BOOL success = [URL setResourceValue:@YES
                                  forKey:NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

#pragma mark -
#pragma mark System Check
+ (BOOL)canSendSMS{
    BOOL canSMS=NO;
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass != nil) {
        if ([messageClass canSendText]) {
            canSMS=YES;
        }
    }
    return canSMS;
}

+ (BOOL)checkNetworkConnection{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}


#pragma mark -
#pragma mark Memory
+ (void)simulateMemoryWarning{
#if TARGET_IPHONE_SIMULATOR
#ifdef DEBUG
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(),
                                         (CFStringRef)@"UISimulatedMemoryWarningNotification", NULL, NULL, true);
#endif
#endif
}


@end
