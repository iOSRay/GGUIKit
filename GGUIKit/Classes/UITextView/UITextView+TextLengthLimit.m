//
//  UITextView+TextLengthLimit.m
//  Beansmile
//
//  Created by John on 20/6/16.
//

#import "UITextView+TextLengthLimit.h"
#import <objc/runtime.h>
#import "NSString+RemoveEmoji.h"
#import "GGStringTool.h"

static void * oneChineseEqualTwoEnglishCharacterPropertyKey = &oneChineseEqualTwoEnglishCharacterPropertyKey;

static void * removeEmojiPropertyKey = &removeEmojiPropertyKey;

@implementation UITextView (TextLengthLimit)

- (void)addTextChangeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewTextDidChangeNotification:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:nil];
}

- (void)textViewTextDidChangeNotification:(NSNotification *)notification{
    NSRange range = self.selectedRange;
    if (self.oneChineseEqualTwoEnglishCharacter) {
        NSUInteger  maxNumber  = (self.textLengthRange.location + self.textLengthRange.length);
        NSInteger length = [GGStringTool oneChineseEqualTwoEnglishLengthWithValidateStr:self.text];
        
        if (length > maxNumber*2 && self.markedTextRange == nil) {
            [self setText:[GGStringTool oneChineseEqualTwoEnglishCutStringToLen:maxNumber withStr:self.text]];
        }
    }else{
        NSUInteger  maxNumber  = (self.textLengthRange.location + self.textLengthRange.length);
        NSString *cutEmojiString = self.removeEmoji?[self.text removedEmojiString]:self.text;
        NSInteger length = [GGStringTool lengthWithValidateStr:cutEmojiString];
        
        if (self.markedTextRange == nil) {
            if (length > maxNumber) {
                [self setText:[GGStringTool normalCutStringToLen:maxNumber withStr:cutEmojiString]];
                [self setSelectedRange:range];
            }else {
                [self setText:cutEmojiString];
                [self setSelectedRange:range];
            }
        }else if (self.removeEmoji && [[self textInRange:self.markedTextRange] isIncludingEmoji]) {
            [self setText:cutEmojiString];
            [self setSelectedRange:range];
        }
    }
}

- (void)setTextLengthRange:(NSRange)textLengthRange{
    [self addTextChangeNotification];
    objc_setAssociatedObject(self, @selector(textLengthRange), [NSValue valueWithRange:textLengthRange], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSRange)textLengthRange{
    NSValue *value = objc_getAssociatedObject(self, @selector(textLengthRange));
    if (value) {
        return value.rangeValue;
    }
    return NSMakeRange(0, NSUIntegerMax);
}

- (BOOL)oneChineseEqualTwoEnglishCharacter{
    NSNumber *number = objc_getAssociatedObject(self, &oneChineseEqualTwoEnglishCharacterPropertyKey);
    return [number boolValue];
}

- (void)setOneChineseEqualTwoEnglishCharacter:(BOOL)oneChineseEqualTwoEnglishCharacter{
    NSNumber *number = [NSNumber numberWithBool: oneChineseEqualTwoEnglishCharacter];
    objc_setAssociatedObject(self, &oneChineseEqualTwoEnglishCharacterPropertyKey, number , OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)removeEmoji{
    NSNumber *number = objc_getAssociatedObject(self, &removeEmojiPropertyKey);
    return [number boolValue];
}

- (void)setRemoveEmoji:(BOOL)removeEmoji{
    NSNumber *number = [NSNumber numberWithBool: removeEmoji];
    objc_setAssociatedObject(self, &removeEmojiPropertyKey, number , OBJC_ASSOCIATION_RETAIN);
}

@end
