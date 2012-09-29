//
//  ReadLaterInstapaper.m
//  ReadLater
//
//  Created by Jason Dinh on 26/9/12.
//  Copyright (c) 2012 Tiny Whale. All rights reserved.
//

#import "ReadLaterInstapaper.h"

@implementation ReadLaterInstapaper

- (id) initWithConsumerKey: (NSString *) consumerKey consumerSecret: (NSString *) consumerSecret {
    self = [super initWithConsumerKey: consumerKey consumerSecret:consumerSecret];
    if (self) {
        self.tokenURL = INSTAPAPER_TOKEN_URL;
        self.bookmarkURL = INSTAPAPER_BOOKMARK_URL;
    }
    return self;
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if (self.requestType == ReadLaterRequestTypeToken) {
        if (self.httpResponse.statusCode == 200) {
            NSString *response = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
            NSArray *tmpArray = [response componentsSeparatedByString: @"&"];
            NSMutableDictionary *tokenDict = [NSMutableDictionary dictionary];
            [tmpArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
                NSArray *tmpArray2 = [obj componentsSeparatedByString: @"="];
                NSString *key = (NSString *) [tmpArray2 objectAtIndex:0];
                [tokenDict setValue: [tmpArray2 objectAtIndex:1] forKey: key];
            }];
            
            if (self.delegate && [self.delegate respondsToSelector: @selector(getTokenForInstapaperSuccess:)]) {
                [self.delegate getTokenForInstapaperSuccess: tokenDict];
            }
        }
        else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(getTokenForInstapaperFail:)]) {
                NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                [errorDetail setValue:@"Instapaper token failed" forKey:NSLocalizedDescriptionKey];
                NSError *error = [NSError errorWithDomain: @"Instapaper" code: self.httpResponse.statusCode userInfo: errorDetail];
                [self.delegate getTokenForInstapaperFail: error];
            }
        }
    }
    else if (self.requestType == ReadLaterRequestTypeBookmark) {
        if (self.httpResponse.statusCode == 200) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(saveToInstapaperSuccess:)]) {
                [self.delegate saveToInstapaperSuccess: self.url];
            }
        }
        else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(saveToInstapaperFail:error:)]) {
                NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                [errorDetail setValue:@"Instapaper failed: not logged in" forKey:NSLocalizedDescriptionKey];
                NSError *error = [NSError errorWithDomain: @"Instapaper" code: self.httpResponse.statusCode userInfo: errorDetail];
                [self.delegate saveToInstapaperFail: self.url error: error];
            }
        }
    }
}



@end
