//
//  GGUtil.h
//  VisibleTools
//
//  Created by gump on 11-5-13.
//  Copyright 2011年 f4 . All rights reserved.
//

@interface GGUtil : NSObject

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

+ (BOOL)canSendSMS;

+ (BOOL)checkNetworkConnection;

+ (void)simulateMemoryWarning;

@end
