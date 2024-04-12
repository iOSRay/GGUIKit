//
//  UICollectionViewCell+GGNib.m
//  Beansmile
//
//  Created by John on 16/5/16.
//

#import "UICollectionViewCell+GGNib.h"

@implementation UICollectionViewCell (GGNib)

+ (NSString*)reuseIdentifier{
    return NSStringFromClass([self class]);
}

+ (UINib *)nib{
    NSString *xibName = NSStringFromClass([self class]);
    return [UINib nibWithNibName:xibName bundle:nil];
}

@end
