//
//  GGSavePhotoTool.h
//  Beansmile
//
//  Created by John on 2018/9/28.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface GGSavePhotoTool : NSObject

+ (void)requestAuthorizationCompletion:(void (^)(PHAuthorizationStatus status))completion;
+ (void)authorizationStatusForMediaType:(AVMediaType)mediaType completion:(void (^)(AVAuthorizationStatus status))completion;
+ (void)savaPhoto:(UIImage *)image;

@end
