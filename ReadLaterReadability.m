//
//  ReadLaterReadability.m
//  ReadLater
//
//  Created by Jason Dinh on 26/9/12.
//  Copyright (c) 2012 Tiny Whale. All rights reserved.
//

#import "ReadLaterReadability.h"

@implementation ReadLaterReadability

- (id) initWithConsumerKey: (NSString *) consumerKey consumerSecret: (NSString *) consumerSecret {
    self = [super initWithConsumerKey: consumerKey consumerSecret:consumerSecret];
    if (self) {
        self.tokenURL = READABILITY_TOKEN_URL;
        self.bookmarkURL = READABILITY_BOOKMARK_URL;
    }
    return self;
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [super connection: connection didReceiveResponse: response];
    if (self.requestType == ReadLaterRequestTypeBookmark) {
        if (self.httpResponse.statusCode == 202) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(saveToReadabilitySuccess:)]) {
                [self.delegate saveToReadabilitySuccess: self.url];
            }
        }
        else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(saveToReadabilityFail:error:)]) {
                NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                switch (self.httpResponse.statusCode) {
                    case 400:
                        [errorDetail setValue:@"Bad Request: The server could not understand your request. Verify that request parameters (and content, if any) are valid." forKey:NSLocalizedDescriptionKey];
                        break;
                    case 401:
                        [errorDetail setValue:@"Authorization Required: Authentication failed or was not provided. Verify that you have sent valid credentials." forKey:NSLocalizedDescriptionKey];
                        break;
                    case 409:
                        [errorDetail setValue:@"Conflict: The resource that you are trying to create already exists." forKey:NSLocalizedDescriptionKey];
                        break;
                    case 500:
                        [errorDetail setValue:@"Internal Server Error: An unknown error has occurred." forKey:NSLocalizedDescriptionKey];
                        break;
                    default:
                        [errorDetail setValue:@"An unknown error has occurred." forKey:NSLocalizedDescriptionKey];
                        break;
                }
                NSError *error = [NSError errorWithDomain: @"Readability" code: self.httpResponse.statusCode userInfo: errorDetail];
                [self.delegate saveToReadabilityFail: self.url error:error];
            }
        }
    }
    
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
            
            if (self.delegate && [self.delegate respondsToSelector: @selector(getTokenForReadabilitySuccess:)]) {
                [self.delegate getTokenForReadabilitySuccess: tokenDict];
            }
        }
        else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(getTokenForReadabilityFail:)]) {
                NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                [errorDetail setValue:@"Readability token failed" forKey:NSLocalizedDescriptionKey];
                NSError *error = [NSError errorWithDomain: @"Readability" code: self.httpResponse.statusCode userInfo: errorDetail];
                [self.delegate getTokenForReadabilityFail: error];
            }
        }
    }
}


@end
