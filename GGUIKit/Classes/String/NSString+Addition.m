//
//  NSString+Addition.m
//  Beansmile
//
//  Created by John on 16/5/4.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)

- (BOOL)isValidateMobile{
    if (self.length!=11) {
        return NO;
    }
    NSString *phoneRegex = @"^((13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

-(NSString *) ebg13String{
    const char *_string = [self cStringUsingEncoding:NSASCIIStringEncoding];
    NSUInteger stringLength = [self length];
    char newString[stringLength+1];
    int x;
    for( x=0; x<stringLength; x++ ){
        unsigned int aCharacter = _string[x];
        
        if( 0x40 < aCharacter && aCharacter < 0x5B ) // A - Z
            newString[x] = (((aCharacter - 0x41) + 0x0D) % 0x1A) + 0x41;
        else if( 0x60 < aCharacter && aCharacter < 0x7B ) // a-z
            newString[x] = (((aCharacter - 0x61) + 0x0D) % 0x1A) + 0x61;
        else  // Not an alpha character
            newString[x] = aCharacter;
    }
    newString[x] = '\0';
    NSString *ebgString = [NSString stringWithCString:newString encoding:NSASCIIStringEncoding];
    return( ebgString );
}

+ (NSString *)infoByKey:(NSString *)key NeedEbg:(BOOL)need{
    NSString *infoOriginString = [[[NSBundle mainBundle] infoDictionary] objectForKey:key];
    if (need) {
        infoOriginString = [infoOriginString ebg13String];
    }
    return infoOriginString;
}

- (NSString *)reverseString {
    unsigned int *cstr, buf, len = [self length], i;
    cstr  = (unsigned int *)[self cStringUsingEncoding:NSUTF32LittleEndianStringEncoding];
    for (i=0;i < len/2;i++) buf = cstr[i], cstr[i] = cstr[len -i-1], cstr[len-i-1] = buf;
    return [[NSString alloc] initWithBytesNoCopy:cstr length:len*4 encoding:NSUTF32LittleEndianStringEncoding freeWhenDone:NO];
}

@end
