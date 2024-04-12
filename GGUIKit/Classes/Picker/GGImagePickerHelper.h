//
//  GGImagePickerHelper.h
//  Beansmile
//
//  Created by Loong Lam on 15/4/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^imagePickerHandler)(UIImage *image, NSDictionary *meta);

@interface GGImagePickerHelper : NSObject

@property (nonatomic, assign) BOOL shouldSavePhoto;//调用相机时是否保存拍摄的照片
@property (nonatomic, assign) BOOL allowsEditing;
@property (nonatomic, strong) imagePickerHandler finishPickingImageHandler;

- (void)showImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType
                        allowsEditing:(BOOL)allowsEditing
              finishPickingImageHandler:(imagePickerHandler)handler;

+ (GGImagePickerHelper *)sharedInstance;

@end
