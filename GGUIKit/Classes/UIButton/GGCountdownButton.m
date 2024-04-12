//
//  GGCountdownButton.m
//  Beansmile
//
//  Created by John on 2018/5/29.
//

#import "GGCountdownButton.h"

@interface GGCountdownButton ()

@property (nonatomic, strong) NSString *originTitle;
@property (nonatomic, strong) UIColor *originBackgroundColor;
@property (nonatomic, strong) UIColor *originTitleColor;
@property (nonatomic, strong) YYTimer *timer;
@property (nonatomic, assign) NSInteger time;

@end

@implementation GGCountdownButton

- (void)dealloc{
    if (self.timer) {
        [self.timer invalidate];
    }
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self p_setup];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self p_setup];
    }
    return self;
}

- (void)p_setup{
    if (_cornerRadius > 0) {
        self.layer.cornerRadius = _cornerRadius;
        self.layer.masksToBounds = YES;
    }
    if ([self borderColor]) {
        self.layer.borderColor = [self borderColor].CGColor;
        self.layer.borderWidth = 0.5;
    }
    _originBackgroundColor = self.backgroundColor;
    _originTitleColor = [self titleColorForState:UIControlStateNormal];
    _originTitle = [self titleForState:UIControlStateNormal];
}

- (void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    if (enabled) {
        [self setBackgroundColor:self.originBackgroundColor];
    }else{
        [self setBackgroundColor:self.disableColor];
    }
}

- (void)beginCountdown{
    if (_time > 0) {
        return;
    }
    _time = 60;
    _timer = [YYTimer timerWithTimeInterval:1 target:self selector:@selector(countdown) repeats:YES];
    [_timer fire];
}

- (void)stopCountdown{
    [self setUserInteractionEnabled:YES];
    NSAttributedString *attributedTitle = [[NSAttributedString alloc]initWithString:self.originTitle attributes:@{NSFontAttributeName:self.titleLabel.font,NSForegroundColorAttributeName:_originTitleColor}];
    [self setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)countdown{
    if (_time < 0) {
        [self stopCountdown];
    }else{
        [self setUserInteractionEnabled:NO];
        NSString *title = [NSString stringWithFormat:@"%@ %@", self.disableTitle ? : @"重新发送", @(_time)];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc]initWithString:title attributes:@{NSFontAttributeName:self.titleLabel.font,NSForegroundColorAttributeName:self.disableColor}];
        [self setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    }
    _time--;
}

@end
