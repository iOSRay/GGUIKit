//
//  UITextField+TextLengthLimit.h
//  Beansmile
//
//  Created by John on 20/6/16.
//

#import <UIKit/UIKit.h>
/**
 *  用法：
 *
 *  self.textField.textLengthRange = NSMakeRange(0, 30);
 *
 *  备注：记得在设置 textLengthRange 所在的 controller 执行：
 *
 *   [[NSNotificationCenter defaultCenter] removeObserver:self.textField];
 */
@interface UITextField (TextLengthLimit)

@property (nonatomic, assign) NSRange textLengthRange;

//满足15个中文或30个英文的字数限制
@property (nonatomic, assign) BOOL oneChineseEqualTwoEnglishCharacter;

//满足不允许输入emoji的需求
@property (nonatomic, assign) BOOL removeEmoji;


@end
