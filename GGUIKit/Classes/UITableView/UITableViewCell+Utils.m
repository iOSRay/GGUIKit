//
//  UITableViewCell+Utils.m
//  Beansmile
//
//  Created by John on 11/3/15.
//

#import "UITableViewCell+Utils.h"

@implementation UITableViewCell(Utils)

+ (NSString*)reuseIdentifier{
    return NSStringFromClass([self class]);
}

+ (UINib *)nib{
    NSString *xibName = NSStringFromClass([self class]);
    return [UINib nibWithNibName:xibName bundle:[NSBundle mainBundle]];
}

@end
