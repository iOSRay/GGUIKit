//
//  UICollectionReusableView+GGUtils.m
//  Beansmile
//
//  Created by John on 18/10/2016.
//

#import "UICollectionReusableView+GGUtils.h"

@implementation UICollectionReusableView (GGUtils)

+ (NSString*)reuseIdentifier{
    return NSStringFromClass([self class]);
}

+ (UINib *)nib{
    NSString *xibName = NSStringFromClass([self class]);
    return [UINib nibWithNibName:xibName bundle:[NSBundle mainBundle]];
}

@end
