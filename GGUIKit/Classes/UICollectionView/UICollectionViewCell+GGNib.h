//
//  UICollectionViewCell+GGNib.h
//  Beansmile
//
//  Created by John on 16/5/16.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (GGNib)

+ (NSString*)reuseIdentifier;

+ (UINib *)nib;

@end
