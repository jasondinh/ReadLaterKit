//
//  ReadLaterKit.h
//  ReadLater
//
//  Created by Jason Dinh on 26/9/12.
//  Copyright (c) 2012 Tiny Whale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReadLaterConfiguration.h"
#import "ReadLaterInstapaper.h"
#import "ReadLaterPocket.h"
#import "ReadLaterReadability.h"

typedef enum {
    ReadLaterServiceTypeInstapaper,
    ReadLaterServiceTypePocket,
    ReadLaterServiceTypeReadability
} ReadLaterServiceType;

@protocol ReadLaterDelegate <NSObject>
@optional

- (void) readLaterGetTokenForInstapaperSuccess;
- (void) readLaterGetTokenForInstapaperFail: (NSError *) error;

- (void) readLaterSaveToInstapaperSuccess: (NSURL *) url;
- (void) readLaterSaveToInstapaperFail:(NSURL *)url error: (NSError *) error;

- (void) readLaterSaveToPocketSuccess: (NSURL *) url;
- (void) readLaterSaveToPocketFail:(NSURL *)url error: (NSError *) error;

- (void) readLaterGetTokenForReadabilitySuccess;
- (void) readLaterGetTokenForReadabilityFail: (NSError *) error;

- (void) readLaterSaveToReadabilitySuccess: (NSURL *) url;
- (void) readLaterSaveToReadabilityFail:(NSURL *)url error: (NSError *) error;

@end

@interface ReadLaterKit : NSObject <NSURLConnectionDataDelegate, ReadLaterPocketDelegate, ReadLaterInstapaperDelegate, ReadLaterReadabilityDelegate> {
    
}

@property (strong) NSString *instapaperOAuthToken;
@property (strong) NSString *instapaperOAuthSecret;
@property (strong) NSString *pocketUsername;
@property (strong) NSString *pocketPassword;
@property (strong) NSString *readabilityOAuthToken;
@property (strong) NSString *readabilityOAuthSecret;
@property (weak) id<ReadLaterDelegate> delegate;

- (void) saveURL: (NSURL *) url toService: (ReadLaterServiceType) readLaterService;
- (void) getInstapaperTokenForUser: (NSString *) username password: (NSString *) password;
- (void) getReadabilityTokenForUser: (NSString *) username password: (NSString *) password;
@end

