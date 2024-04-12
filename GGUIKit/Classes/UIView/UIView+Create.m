//
//  UIView+Create.m
//  Beansmile
//
//  Created by John on 14-3-22.
//

#import "UIView+Create.h"

@implementation UIView(Create)

+ (id)loadFromNib{
    NSString *xibName = NSStringFromClass([self class]);
    return [[[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil] firstObject];
}

+ (UINib *)nib{
    NSString *xibName = NSStringFromClass([self class]);
    return [UINib nibWithNibName:xibName bundle:[NSBundle mainBundle]];
}

+ (NSString*)reuseIdentifier{
    return NSStringFromClass([self class]);
}

@end
