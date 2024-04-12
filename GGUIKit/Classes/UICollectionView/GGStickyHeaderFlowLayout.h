//
//  GGStickyHeaderFlowLayout.h
//  Haituncun
//
//  Created by Waley on 6/30/23.
//  Copyright © 2023 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GGStickyHeaderFlowLayout : UICollectionViewFlowLayout
// 悬浮起点
@property (nonatomic, assign) NSInteger navigationHeight;
// 悬浮sections
@property (nonatomic, strong) NSArray <NSNumber *>*sections;

@end

NS_ASSUME_NONNULL_END
