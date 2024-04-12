//
//  GGTableViewModel.m
//  Beansmile
//
//  Created by John on 2018/4/26.
//

#import "GGTableViewModel.h"

@implementation GGTableViewModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"dataSource" :[GGViewModel class]};
}

@end
