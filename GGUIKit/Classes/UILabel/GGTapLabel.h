//
//  GGTapLabel.h
//  Beansmile
//
//  Created by John on 2018/11/15.
//

#import <UIKit/UIKit.h>

@interface GGTapLabel : UILabel

- (void)addHighContentTapByRange:(NSRange)range tapBlock:(voidBlock)block;

@end

