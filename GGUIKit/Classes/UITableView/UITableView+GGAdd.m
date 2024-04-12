//
//  UITableView+GGAdd.m
//  Beansmile
//
//  Created by John on 14/12/2017.
//

#import "UITableView+GGAdd.h"
#import "PureLayout.h"
#import "UIView+LayoutConstraintHelper.h"

@implementation UITableView (GGAdd)

- (void)gg_insertHeaderView:(UIView *)headerView{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerView.heightConstraint.constant)];
    self.tableHeaderView = header;
    [header addSubview:headerView];
    [headerView autoPinEdgesToSuperviewEdges];
    [headerView layoutIfNeeded];
}

- (void)gg_insertFooterView:(UIView *)footerView{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, footerView.heightConstraint.constant)];
    self.tableFooterView = footer;
    [footer addSubview:footerView];
    [footerView autoPinEdgesToSuperviewEdges];
    [footerView layoutIfNeeded];
}

- (void)registerClassOrNibForCellReuseIdentifier:(NSString *)identifier{
    Class class = NSClassFromString(identifier);
    NSString *xibName = NSStringFromClass(class);
    UINib *nib = [UINib nibWithNibName:xibName bundle:[NSBundle mainBundle]];
    if([[NSBundle mainBundle] pathForResource:xibName ofType:@"nib"] != nil){
        [self registerNib:nib forCellReuseIdentifier:identifier];
    }else{
        [self registerClass:class forCellReuseIdentifier:identifier];
    }
}

- (void)registerClassOrNibForHeaderReuseIdentifier:(NSString *)identifier{
    Class class = NSClassFromString(identifier);
    NSString *xibName = NSStringFromClass(class);
    UINib *nib = [UINib nibWithNibName:xibName bundle:[NSBundle mainBundle]];
    if([[NSBundle mainBundle] pathForResource:xibName ofType:@"nib"] != nil){
        [self registerNib:nib forHeaderFooterViewReuseIdentifier:identifier];
    }else{
        [self registerClass:class forHeaderFooterViewReuseIdentifier:identifier];
    }
}

@end
