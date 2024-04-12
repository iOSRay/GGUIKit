//
//  UILabel+FormattedText.m
//  UILabel+FormattedText
//
//  Created by Joao Costa on 3/1/13.
//  Copyright (c) 2013 none. All rights reserved.
//

#import "UILabel+FormattedText.h"

@implementation UILabel (FormattedText)

- (void)addAttributes:(NSDictionary *)attributes range:(NSRange)range {
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.attributedText];
    [text addAttributes:attributes range:range];
    [self setAttributedText: text];
}

- (void)setTextColor:(UIColor *)textColor range:(NSRange)range{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.attributedText];
    [text addAttribute: NSForegroundColorAttributeName
                 value: textColor
                 range: range];
    
    [self setAttributedText: text];
}

- (void)setFont:(UIFont *)font range:(NSRange)range{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.attributedText];
    [text addAttribute: NSFontAttributeName
                 value: font
                 range: range];
    
    [self setAttributedText: text];
}

- (void)setLineSpace:(CGFloat)space{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineSpacing = space;
    [text addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.text.length)];
    [self setAttributedText: text];
}

- (void)setWordSpace:(CGFloat)space {
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:self.text attributes:@{NSKernAttributeName : @(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [text addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.text.length)];
    [self setAttributedText: text];
}

- (void)setLineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace {
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:self.text attributes:@{NSKernAttributeName : @(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [text addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.text.length)];
    [self setAttributedText:text];
}

- (CGFloat)contentHeight{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    
    NSDictionary *attrDict = [NSDictionary dictionaryWithObjectsAndKeys:self.font,
                              NSFontAttributeName,
                              paragraphStyle,
                              NSParagraphStyleAttributeName,
                              nil];
    
    CGRect lblRect = [self.text boundingRectWithSize:(CGSize){self.frame.size.width, MAXFLOAT}
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:attrDict
                                             context:nil];
    return lblRect.size.height;
}

- (NSArray *)textLines {
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([self.font fontName]), [self.font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, self.frame.size.width, 100000));

    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc] init];

    for (id line in lines) {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [self.text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    CFRelease(myFont);
    CFRelease(frameSetter);
    CFRelease(path);
    CFRelease(frame);
    return linesArray;
}

- (NSArray *)attributedTextLines {
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)self.attributedText);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, self.frame.size.width, 100000));

    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc] init];
    
    for (id line in lines) {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [self.attributedText.string substringWithRange:range];
        [linesArray addObject:lineString];
    }
    CFRelease(frameSetter);
    CFRelease(path);
    CFRelease(frame);
    return linesArray;
}
@end
