//
//  ReadLaterKit.m
//  ReadLater
//
//  Created by Jason Dinh on 26/9/12.
//  Copyright (c) 2012 Tiny Whale. All rights reserved.
//

#import "ReadLaterKit.h"

@implementation ReadLaterKit

- (void) getInstapaperTokenForUser: (NSString *) username password: (NSString *) password {
    ReadLaterInstapaper *instapaper = [[ReadLaterInstapaper alloc] initWithConsumerKey: INSTAPAPER_CONSUMER_KEY consumerSecret: INSTAPAPER_SECRET_KEY];
    instapaper.delegate = self;
    [instapaper getTokenForUser:username password:password];
}

- (void) getReadabilityTokenForUser: (NSString *) username password: (NSString *) password {
    ReadLaterReadability *readability = [[ReadLaterReadability alloc] initWithConsumerKey: READABILITY_CONSUMER_KEY consumerSecret: READABILITY_SECRET_KEY];
    readability.delegate = self;
    [readability getTokenForUser:username password:password];
}

- (void) saveURL: (NSURL *) url toService: (ReadLaterServiceType) readLaterService {
    switch (readLaterService) {
        case ReadLaterServiceTypeInstapaper:
            if (!self.instapaperOAuthToken || !self.instapaperOAuthSecret) {
                if (self.delegate && [self.delegate respondsToSelector: @selector(readLaterSaveToInstapaperFail:error:)]) {
                    NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                    [errorDetail setValue:@"You need to get token & secret first" forKey:NSLocalizedDescriptionKey];
                    NSError *error = [NSError errorWithDomain: @"Instapaper" code: 0 userInfo:errorDetail];
                    [self.delegate readLaterSaveToInstapaperFail: url error: error];
                }
                return;
            }
            [self saveURLToInstapaper: url];
            break;
        case ReadLaterServiceTypePocket:
            if (!self.pocketUsername || !self.pocketPassword) {
                if (self.delegate && [self.delegate respondsToSelector: @selector(readLaterSaveToPocketFail:error:)]) {
                    NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                    [errorDetail setValue:@"No username and/or password provided" forKey:NSLocalizedDescriptionKey];
                    NSError *error = [NSError errorWithDomain: @"Pocket" code: 0 userInfo:errorDetail];
                    [self.delegate readLaterSaveToPocketFail: url error: error];
                }
                return;
            }
            [self saveURLToPocket: url];
            break;
        case ReadLaterServiceTypeReadability:
            if (!self.readabilityOAuthToken || !self.readabilityOAuthSecret) {
                if (self.delegate && [self.delegate respondsToSelector: @selector(readLaterSaveToReadabilityFail:error:)]) {
                    NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                    [errorDetail setValue:@"You need to get token & secret first" forKey:NSLocalizedDescriptionKey];
                    NSError *error = [NSError errorWithDomain: @"Readability" code: 0 userInfo:errorDetail];
                    [self.delegate readLaterSaveToReadabilityFail: url error: error];
                }
                return;
            }
            [self saveURLToReadability: url];
        default:
            break;
    }
}

#pragma private functions

- (void) saveURLToInstapaper: (NSURL *) url {
    ReadLaterInstapaper *instapaper = [[ReadLaterInstapaper alloc] initWithConsumerKey: INSTAPAPER_CONSUMER_KEY consumerSecret: INSTAPAPER_SECRET_KEY oAuthToken:self.instapaperOAuthToken oAuthSecret: self.instapaperOAuthSecret];
    instapaper.delegate = self;
    [instapaper saveURL: url];
}

- (void) saveURLToPocket: (NSURL *) url {
    ReadLaterPocket *pocket = [[ReadLaterPocket alloc] initWithUsername: self.pocketUsername password:self.pocketPassword];
    pocket.delegate = self;
    [pocket saveURL: url];
}

- (void) saveURLToReadability: (NSURL *) url {
    ReadLaterReadability *readability = [[ReadLaterReadability alloc] initWithConsumerKey: READABILITY_CONSUMER_KEY consumerSecret: READABILITY_SECRET_KEY oAuthToken:self.readabilityOAuthToken oAuthSecret: self.readabilityOAuthSecret];
    readability.delegate = self;
    [readability saveURL: url];
}


#pragma pocket delegate

- (void) saveToPocketSuccess:(NSURL *)url {
    if (self.delegate && [self.delegate respondsToSelector: @selector(readLaterSaveToPocketSuccess:)]) {
        [self.delegate readLaterSaveToPocketSuccess: url];
    }
}

- (void) saveToPocketFail:(NSURL *)url error:(NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector: @selector(readLaterSaveToPocketFail:error:)]) {
        [self.delegate readLaterSaveToPocketFail: url error: error];
    }
}

#pragma instapaper delegate

- (void) getTokenForInstapaperSuccess:(NSDictionary *)tokenDict {
    if (self.delegate && [self.delegate respondsToSelector: @selector(readLaterGetTokenForInstapaperSuccess)]) {
        self.instapaperOAuthSecret = [tokenDict objectForKey: @"oauth_token_secret"];
        self.instapaperOAuthToken = [tokenDict objectForKey: @"oauth_token"];
        [self.delegate readLaterGetTokenForInstapaperSuccess];
    }
}
- (void) getTokenForInstapaperFail: (NSError *) error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(readLaterGetTokenForInstapaperFail:)]) {
        [self.delegate readLaterGetTokenForInstapaperFail: error];
    }
}

- (void) saveToInstapaperSuccess: (NSURL *) url {
    if (self.delegate && [self.delegate respondsToSelector: @selector(readLaterSaveToInstapaperSuccess:)]) {
        [self.delegate readLaterSaveToInstapaperSuccess: url];
    }
}
- (void) saveToInstapaperFail:(NSURL *)url error: (NSError *) error {
    if (self.delegate && [self.delegate respondsToSelector: @selector(readLaterSaveToInstapaperFail:error:)]) {
        [self.delegate readLaterSaveToInstapaperFail: url error: error];
    }
}

#pragma readability delegate

- (void) getTokenForReadabilitySuccess:(NSDictionary *)tokenDict {
    if (self.delegate && [self.delegate respondsToSelector: @selector(readLaterGetTokenForReadabilitySuccess)]) {
        self.readabilityOAuthSecret = [tokenDict objectForKey: @"oauth_token_secret"];
        self.readabilityOAuthToken = [tokenDict objectForKey: @"oauth_token"];
        [self.delegate readLaterGetTokenForReadabilitySuccess];
    }
}
- (void) getTokenForReadabilityFail: (NSError *) error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(readLaterGetTokenForReadabilityFail:)]) {
        [self.delegate readLaterGetTokenForReadabilityFail: error];
    }
}

- (void) saveToReadabilitySuccess: (NSURL *) url {
    if (self.delegate && [self.delegate respondsToSelector: @selector(readLaterSaveToReadabilitySuccess:)]) {
        [self.delegate readLaterSaveToReadabilitySuccess: url];
    }
}
- (void) saveToReadabilityFail:(NSURL *)url error: (NSError *) error {
    if (self.delegate && [self.delegate respondsToSelector: @selector(readLaterSaveToReadabilityFail:error:)]) {
        [self.delegate readLaterSaveToReadabilityFail: url error: error];
    }
}

@end
