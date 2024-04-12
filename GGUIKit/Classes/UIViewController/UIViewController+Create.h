//
//  UIViewController+Create.h
//  Beansmile
//
//  Created by John on 14-2-24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIViewController(Create)

+ (id)create;

+ (id)createFromStoryboardName:(NSString *)name;

+ (id)createFromStoryboardName:(NSString *)name withIdentifier:(NSString *)identifier;

@end
