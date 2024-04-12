//
//  GGCountdownButton.h
//  Beansmile
//
//  Created by John on 2018/5/29.
//

#import <UIKit/UIKit.h>

@interface GGCountdownButton : UIButton

@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, strong) IBInspectable UIColor *disableColor;
@property (nonatomic, strong) IBInspectable NSString *disableTitle;

- (void)beginCountdown;

@end

