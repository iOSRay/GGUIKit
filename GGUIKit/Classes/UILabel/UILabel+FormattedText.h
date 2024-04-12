//
//  UILabel+FormattedText.h
//  Beansmile
//
//  Created by John on 14-3-22.
//

#import <UIKit/UIKit.h>

@interface UILabel (FormattedText)

- (void)addAttributes:(NSDictionary *)attributes range:(NSRange)range;
- (void)setTextColor:(UIColor *)textColor range:(NSRange)range;
- (void)setFont:(UIFont *)font range:(NSRange)range;
- (void)setLineSpace:(CGFloat)space;
- (void)setWordSpace:(CGFloat)space;
- (void)setLineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace;

- (CGFloat)contentHeight NS_AVAILABLE_IOS(7_0);
- (NSArray *)textLines;
- (NSArray *)attributedTextLines;

@end
