//
//  GGTableViewModel.h
//  Beansmile
//
//  Created by John on 2018/4/26.
//

#import <Foundation/Foundation.h>
#import "GGViewModel.h"

@interface GGTableViewModel : NSObject

@property (nonatomic, strong) GGViewModel *headerModel;
@property (nonatomic, strong) GGViewModel *footerModel;
@property (nonatomic, strong) NSArray<GGViewModel *> *dataSource;

@end
