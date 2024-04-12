//
//  GGMapHelper.m
//  Beansmile
//
//  Created by John on 2017/6/20.
//

#import "GGMapHelper.h"
#import <CoreLocation/CoreLocation.h>

@implementation GGMapHelper

+ (void)openMapByCurrentLocation:(CLLocation *)currentLocation
                    toCoordinate:(CLLocationCoordinate2D)coordinate
                    storeAddress:(NSString *)storeAddress
                byViewController:(UIViewController *)viewController{
    UIAlertController *confirm = [UIAlertController alertControllerWithTitle:@"打开地图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // Sarari
    if (currentLocation) {
        [confirm addAction:[UIAlertAction actionWithTitle:@"Safari" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *url = [NSString stringWithFormat:@"http://apis.map.qq.com/uri/v1/routeplan?type=bus&from=%@&fromcoord=%f,%f&to=%@&tocoord=%f,%f&policy=1&referer=myapp",@"当前位置",
                             currentLocation.coordinate.latitude,currentLocation.coordinate.longitude,storeAddress,coordinate.latitude,coordinate.longitude];
            NSMutableCharacterSet *allowedCharacters = [NSMutableCharacterSet alphanumericCharacterSet];
            [allowedCharacters addCharactersInString:@".:/,&?="];
            NSString *encodedUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:encodedUrl]];
        }]];
    }
    
    // 苹果地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com/"]]) {
        [confirm addAction:[UIAlertAction actionWithTitle:@"苹果地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
            toLocation.name = storeAddress;
            [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
        }]];
    }
    
    // 百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        [confirm addAction:[UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSMutableCharacterSet *allowedCharacters = [NSMutableCharacterSet alphanumericCharacterSet];
            [allowedCharacters addCharactersInString:@".:/,&?="];
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=%f,%f&mode=driving&src=JumpMapDemo", coordinate.latitude, coordinate.longitude] stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }]];
    }
    
    // 高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        [confirm addAction:[UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSMutableCharacterSet *allowedCharacters = [NSMutableCharacterSet alphanumericCharacterSet];
            [allowedCharacters addCharactersInString:@".:/,&?="];
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&sname=我的位置&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0", coordinate.latitude, coordinate.longitude,storeAddress] stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }]];
    }
    
    // 腾讯地图
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]])    {
        [confirm addAction:[UIAlertAction actionWithTitle:@"腾讯地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSMutableCharacterSet *allowedCharacters = [NSMutableCharacterSet alphanumericCharacterSet];
            [allowedCharacters addCharactersInString:@".:/,&?="];
            NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?type=drive&from=我的位置&to=%@&tocoord=%f,%f&policy=1&referer=%@", storeAddress, coordinate.latitude, coordinate.longitude, @"MapJump"] stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }]];
    }
    [confirm addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [viewController presentViewController:confirm animated:YES completion:nil];
}

@end
