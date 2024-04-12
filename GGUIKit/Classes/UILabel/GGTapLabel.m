//
//  GGTapLabel.m
//  Beansmile
//
//  Created by John on 2018/11/15.
//

#import "GGTapLabel.h"

@interface GGTapLabel ()

@property (nonatomic, assign) NSRange range;
@property (nonatomic, strong) voidBlock tapBlock;

@end

@implementation GGTapLabel

- (void)addHighContentTapByRange:(NSRange)range tapBlock:(voidBlock)block {
    self.range = range;
    self.tapBlock = block;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = YES;
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    NSLayoutManager *layoutManager = [NSLayoutManager new];
    NSTextContainer *textContainer = [[NSTextContainer alloc]initWithSize:CGSizeZero];
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:self.attributedText];
    
    // Configure layoutManager and textStorage
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    
    // Configure textContainer
    textContainer.lineFragmentPadding = 0.0;
    textContainer.lineBreakMode = self.lineBreakMode;
    textContainer.maximumNumberOfLines = self.numberOfLines;
    CGSize labelSize = self.bounds.size;
    textContainer.size = labelSize;
    
    CGPoint locationOfTouchInLabel = [sender locationInView:self];
    CGRect textBoundingBox = [layoutManager usedRectForTextContainer:textContainer];
    
    CGPoint textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
    
    CGPoint locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x, locationOfTouchInLabel.y - textContainerOffset.y);
    
    NSInteger indexOfCharacter = [layoutManager characterIndexForPoint:locationOfTouchInTextContainer inTextContainer:textContainer fractionOfDistanceBetweenInsertionPoints:nil];
    
    if (NSLocationInRange(indexOfCharacter, self.range)) {
        if (self.tapBlock) {
            self.tapBlock();
        }
    }
}

@end
