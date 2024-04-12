//
//  GGDeviceIdentifier.m
//  Beansmile
//
//  Created by John on 2018/8/6.
//

#import "GGDeviceIdentifier.h"
#import "UICKeyChainStore.h"

#define bundleIdentifier [[NSBundle mainBundle]bundleIdentifier]

@implementation GGDeviceIdentifier

/**
 *  同步唯一设备标识 (生成并保存唯一设备标识,如已存在则不进行任何处理)
 *
 *  @return 是否成功
 */
+ (void)syncDeviceIdentifier {
    
    /**
     *  获取应用的UUID标识
     *  (
     *  identifierForVendor返回本应用的UUID, 卸载重装后会变.所以要存入钥匙串
     *  此处可用 [[NSUUID UUID]UUIDString] 代替, [NSUUID UUID]方法每次调用都会生成一个不同的UUID
     *  但是identifierForVendor可以用来验证是不是第一次安装
     *  )
     */
    NSString *myUUIDStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    /**
     *  保存UUID到钥匙串Keychain, 如果已存在则不保存
     */
    UICKeyChainStore *keychainStore = [UICKeyChainStore keyChainStoreWithService:bundleIdentifier];
    if (!keychainStore[@"deviceIdentifier"]) {
        keychainStore[@"deviceIdentifier"] = myUUIDStr;
    }
}

/**
 *  返回唯一设备标识
 *
 *  @return 设备标识
 */
+ (NSString *)deviceIdentifier {
    //先同步一下, 防止设备标识还未存在的情况
    [self syncDeviceIdentifier];
    UICKeyChainStore *keychainStore = [UICKeyChainStore keyChainStoreWithService:bundleIdentifier];
    //从钥匙串中获取唯一设备标识
    NSString * deviceIdentifier = keychainStore[@"deviceIdentifier"];
    return deviceIdentifier;
}

/**
 *  本应用是第一次安装
 *
 *  @return 是否是第一次安装
 */
+ (BOOL)isFirstInstall {
    
    NSString * deviceIdentifier = [GGDeviceIdentifier deviceIdentifier];
    NSString * identifierForVendor = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    /**
     *  如果钥匙串中存的deviceIdentifier(设备标识)不存在 或者 等于deviceIdentifier(本应用的UUID) , 则为第一次安装
     */
    if ( !deviceIdentifier || [deviceIdentifier isEqualToString:identifierForVendor]) {
        return YES;
    } else {
        return NO;
    }
}

@end
