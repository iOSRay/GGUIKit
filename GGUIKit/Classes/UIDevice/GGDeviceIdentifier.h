//
//  GGDeviceIdentifier.h
//  Beansmile
//
//  Created by John on 2018/8/6.
//

#import <Foundation/Foundation.h>

@interface GGDeviceIdentifier : NSObject

+ (void)syncDeviceIdentifier;

+ (NSString *)deviceIdentifier;

@end
