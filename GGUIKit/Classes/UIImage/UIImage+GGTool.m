//
//  UIImage+GGTool.m
//  Beansmile
//
//  Created by John on 2017/9/11.
//

#import "UIImage+GGTool.h"
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>

NSString *const kLBBlurredImageErrorDomain          = @"com.lucabernardi.blurred_image_additions";

@implementation UIImage (JZTool)

- (UIImage *)imageByTintColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    [color set];
    UIRectFill(rect);
    [self drawAtPoint:CGPointMake(0, 0) blendMode:kCGBlendModeDestinationIn alpha:1];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)scaleToSize:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    //Determine whether the screen is retina
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (UIImage *)imageWithHue:(CGFloat)hue
               saturation:(CGFloat)saturation
               brightness:(CGFloat)brightness
                    alpha:(CGFloat)alpha{
    // Find the image dimensions.
    CGSize imageSize = [self size];
    CGRect imageExtent = CGRectMake(0,0,imageSize.width,imageSize.height);
    
    // Create a context containing the image.
    UIGraphicsBeginImageContext(imageSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawAtPoint:CGPointMake(0,0)];
    
    // Draw the hue on top of the image.
    CGContextSetBlendMode(context, kCGBlendModeHue);
    [[UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha] set];
    UIBezierPath *imagePath = [UIBezierPath bezierPathWithRect:imageExtent];
    [imagePath fill];
    
    // Retrieve the new image.
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

- (UIImage *)gg_waterImageWithImage:(UIImage *)waterImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    CGFloat scale = self.size.width/SCREEN_WIDTH;
    CGFloat waterW = waterImage.size.width * scale;
    CGFloat waterH = waterImage.size.height * scale;
    
    CGFloat waterX = 16;
    CGFloat waterY = self.size.height - waterH - 18;
    
    [waterImage drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/* blur the current image with a box blur algoritm */
- (UIImage*)gg_boxblurImageWithBlur:(CGFloat)blur {
    CIContext *context   = [CIContext contextWithOptions:nil];
    CIImage *sourceImage = [CIImage imageWithCGImage:self.CGImage];
    NSString *clampFilterName = @"CIAffineClamp";
    CIFilter *clamp = [CIFilter filterWithName:clampFilterName];

    if (!clamp) {
        return nil;
    }
    [clamp setValue:sourceImage forKey:kCIInputImageKey];
    CIImage *clampResult = [clamp valueForKey:kCIOutputImageKey];
    // Apply Gaussian Blur filter
    NSString *gaussianBlurFilterName = @"CIGaussianBlur";
    CIFilter *gaussianBlur = [CIFilter filterWithName:gaussianBlurFilterName];
    if (!gaussianBlur) {
        return nil;
    }
    [gaussianBlur setValue:clampResult forKey:kCIInputImageKey];
    [gaussianBlur setValue:[NSNumber numberWithFloat:blur] forKey:@"inputRadius"];
    CIImage *gaussianBlurResult = [gaussianBlur valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:gaussianBlurResult
                                       fromRect:[sourceImage extent]];
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    return image;
}

@end
