//
//  NSString+escapeHTML.m
//  ReadLater
//
//  Created by Jason Dinh on 28/9/12.
//  Copyright (c) 2012 Tiny Whale. All rights reserved.
//

#import "NSString+escapeHTML.h"

@implementation NSString (escapeHTML)
// copy from this answer http://stackoverflow.com/a/8086845/305969
- (NSString *) escapeHTML {
    NSString *escapedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (__bridge CFStringRef) self,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8));
    return escapedString;
}

@end
