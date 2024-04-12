//
//  GGMapHelper.h
//  Beansmile
//
//  Created by John on 2017/6/20.
//

#import <Foundation/Foundation.h>

@interface GGMapHelper : NSObject

/**
 跳转地图 app
 @param currentLocation 当前位置
 @param coordinate 目的位置
 @param storeAddress 目的地地址描述
 @param viewController 控制器
 */
+ (void)openMapByCurrentLocation:(CLLocation *)currentLocation
                    toCoordinate:(CLLocationCoordinate2D)coordinate
                    storeAddress:(NSString *)storeAddress
                byViewController:(UIViewController *)viewController;

@end
