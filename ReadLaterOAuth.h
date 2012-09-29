//
//  ReadLaterOAuth.h
//  ReadLater
//
//  Created by Jason Dinh on 28/9/12.
//  Copyright (c) 2012 Tiny Whale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReadLaterService.h"
#import "ReadLaterConfiguration.h"

typedef enum {
    ReadLaterRequestTypeToken,
    ReadLaterRequestTypeBookmark
} ReadLaterRequestType;

@interface ReadLaterOAuth : ReadLaterService <NSURLConnectionDataDelegate>

@property (strong) NSHTTPURLResponse *httpResponse;
@property ReadLaterRequestType requestType;
@property (strong) NSURL *tokenURL;
@property (strong) NSURL *bookmarkURL;
@property (strong) NSString *consumerKey;
@property (strong) NSString *consumerSecret;
@property (strong) NSString *oAuthToken;
@property (strong) NSString *oAuthSecret;
- (id) initWithConsumerKey: (NSString *) consumerKey consumerSecret: (NSString *) consumerSecret;
- (id) initWithConsumerKey: (NSString *) consumerKey consumerSecret: (NSString *) consumerSecret oAuthToken: (NSString *) oAuthToken oAuthSecret: (NSString *) oAuthSecret;
- (void) getTokenForUser: (NSString *) username password: (NSString *)password;



@end