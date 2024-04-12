//
//  UIStoryboard+Addition.m
//  Beansmile
//
//  Created by John on 13-12-31.
//

#import "UIStoryboard+Addition.h"

@implementation UIStoryboard(Addition)

+ (UIStoryboard*)fromName:(NSString*)name{
    return [UIStoryboard storyboardWithName:name bundle:[NSBundle mainBundle]];
}

@end
