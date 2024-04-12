//
//  UITableView+GGAdd.h
//  Beansmile
//
//  Created by John on 14/12/2017.
//

@interface UITableView (GGAdd)

/**
 适用于 header 使用约束的情况
 */
- (void)gg_insertHeaderView:(UIView *)headerView;

- (void)gg_insertFooterView:(UIView *)footerView;

- (void)registerClassOrNibForCellReuseIdentifier:(NSString *)identifier;

- (void)registerClassOrNibForHeaderReuseIdentifier:(NSString *)identifier;

@end
