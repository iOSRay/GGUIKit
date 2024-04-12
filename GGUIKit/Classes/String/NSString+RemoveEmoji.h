//
//  NSString+RemoveEmoji.h
//  Beansmile
//
//  Created by John on 8/30/16.
//

#import <Foundation/Foundation.h>

@interface NSString (RemoveEmoji)

- (BOOL)isEmoji;

- (BOOL)isIncludingEmoji;

- (instancetype)removedEmojiString;

@end
