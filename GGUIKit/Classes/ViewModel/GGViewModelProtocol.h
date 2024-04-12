//
//  GGViewModelProtocol.h
//  Beansmile
//
//  Created by John on 2018/4/26.
//

@class GGViewModel;

@protocol GGViewModelProtocol <NSObject>

- (void)setViewModel:(GGViewModel *)viewModel;

@optional

+ (NSDictionary *)dicByMapModel:(id)model;

@end

