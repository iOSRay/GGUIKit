//
//  UIView+Create.h
//  Beansmile
//
//  Created by John on 14-3-22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView(Create)

+ (NSString*)reuseIdentifier;

+ (UINib *)nib;

+ (id)loadFromNib;

@end
