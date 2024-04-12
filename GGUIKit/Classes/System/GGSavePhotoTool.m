//
//  GGSavePhotoTool.m
//  Beansmile
//
//  Created by John on 2018/9/28.
//

#import "GGSavePhotoTool.h"
#import <Photos/Photos.h>
#import "UIView+GGProgressHUD.h"
#import "UIViewController+GGTool.h"

@implementation GGSavePhotoTool

+ (PHAuthorizationStatus)authorizationStatus {
    if (@available(iOS 14, *)) {
        PHAccessLevel level = PHAccessLevelReadWrite;
        return [PHPhotoLibrary authorizationStatusForAccessLevel:level];
    }
    return [PHPhotoLibrary authorizationStatus];
}

+ (void)requestAuthorization:(void(^)(PHAuthorizationStatus status))handler {
    if (@available(iOS 14, *)) {
        PHAccessLevel level = PHAccessLevelReadWrite;
        [PHPhotoLibrary requestAuthorizationForAccessLevel:level handler:^(PHAuthorizationStatus authorizationStatus) {
            if (handler) {
                handler(authorizationStatus);
            }
        }];
    } else {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus authorizationStatus) {
            if (handler) {
                handler(authorizationStatus);
            }
        }];
    }
}

+ (void)requestAuthorizationCompletion:(void (^)(PHAuthorizationStatus status))completion {
    PHAuthorizationStatus authorizationStatus = [self authorizationStatus];
    if (authorizationStatus == PHAuthorizationStatusNotDetermined) {
        [self requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(status);
            });
        }];
    } else {
        completion(authorizationStatus);
    }
}

+ (void)authorizationStatusForMediaType:(AVMediaType)mediaType completion:(void (^)(AVAuthorizationStatus status))completion {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"您的设备不支持相机功能" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:nil]];
        [UIViewController.currentViewController presentViewController:alertController animated:YES completion:nil];
        return;
    }
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)]) {
        AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if (authorizationStatus == PHAuthorizationStatusNotDetermined) {
            // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
            [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
                dispatch_sync_on_main_queue(^{
                    if (granted) {
                        completion(AVAuthorizationStatusAuthorized);
                    } else {
                        completion(AVAuthorizationStatusDenied);
                    }
                });
            }];
        } else {
            completion(authorizationStatus);
        }
    }
}

+ (void)savaPhoto:(UIImage *)image {
    [kCurrentWindow showLoadingWithText:@"保存中" animation:YES];
    [self requestAuthorizationCompletion:^(PHAuthorizationStatus status) {
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                case PHAuthorizationStatusLimited:
                case PHAuthorizationStatusAuthorized:
                    [self saveImageToCustomAblum:image];
                    break;
                case PHAuthorizationStatusDenied:
                    [self showError:@"失败！请在系统设置中开启访问相册权限"];
                    break;
                case PHAuthorizationStatusRestricted:
                    [self showError:@"系统原因，无法访问相册"];
                    break;
                    
                default:
                    break;
            }
        });
    }];
}

+ (void)saveImageToCustomAblum:(UIImage *)image{
    //1 将图片保存到系统的【相机胶卷】中---调用刚才的方法
    PHFetchResult<PHAsset *> *assets = [self syncSaveImageWithPhotos:image];
    if (assets == nil){
        [self showError:@"保存失败"];
        return;
    }
    
    //2 拥有自定义相册（与 APP 同名，如果没有则创建）--调用刚才的方法
    PHAssetCollection *assetCollection = [self getAssetCollectionWithAppNameAndCreateIfNo];
    if (assetCollection == nil) {
        [self showError:@"相册创建失败"];
        return;
    }
    
    //3 将刚才保存到相机胶卷的图片添加到自定义相册中 --- 保存带自定义相册--属于增的操作，需要在PHPhotoLibrary的block中进行
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        //--告诉系统，要操作哪个相册
        PHAssetCollectionChangeRequest *collectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        //--添加图片到自定义相册--追加--就不能成为封面了
        //--[collectionChangeRequest addAssets:assets];
        //--插入图片到自定义相册--插入--可以成为封面
        [collectionChangeRequest insertAssets:assets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    
    if (error) {
        [self showError:@"保存失败"];
        return;
    }
    [self showSuccess:@"保存成功"];
}

/**同步方式保存图片到系统的相机胶卷中---返回的是当前保存成功后相册图片对象集合*/
+ (PHFetchResult<PHAsset *> *)syncSaveImageWithPhotos:(UIImage *)image{
    //--1 创建 ID 这个参数可以获取到图片保存后的 asset对象
    __block NSString *createdAssetID = nil;
    
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        //----block 执行的时候还没有保存成功--获取占位图片的 id，通过 id 获取图片---同步
        createdAssetID = [PHAssetChangeRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    if (error) {
        return nil;
    }
    //获取保存到系统相册成功后的 asset 对象集合，并返回
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsWithLocalIdentifiers:@[createdAssetID] options:nil];
    return assets;
}

/**拥有与 APP 同名的自定义相册--如果没有则创建*/
+ (PHAssetCollection *)getAssetCollectionWithAppNameAndCreateIfNo{
    //1 获取以 APP 的名称
    NSString *title = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleDisplayName"];
    //2 获取与 APP 同名的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collections) {
        //遍历
        if ([collection.localizedTitle isEqualToString:title]) {
            //找到了同名的自定义相册--返回
            return collection;
        }
    }    
    //说明没有找到，需要创建
    NSError *error = nil;
    __block NSString *createID = nil; //用来获取创建好的相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        //发起了创建新相册的请求，并拿到ID，当前并没有创建成功，待创建成功后，通过 ID 来获取创建好的自定义相册
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title];
        createID = request.placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    if (error) {
        [self showError:@"保存失败"];
        return nil;
    }else{
        //通过 ID 获取创建完成的相册 -- 是一个数组
        return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createID] options:nil].firstObject;
    }
}

+ (void)showError:(NSString *)message{
    [kCurrentWindow hideHUD:YES];
    [kCurrentWindow showErrorText:message animation:YES autoHide: YES];
}

+ (void)showSuccess:(NSString *)message{
    [kCurrentWindow hideHUD:YES];
    [kCurrentWindow showSuccessText:message animation:YES autoHide: YES];
}

@end
