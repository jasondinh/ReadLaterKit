//
//  ReadLaterOAuth.m
//  ReadLater
//
//  Created by Jason Dinh on 28/9/12.
//  Copyright (c) 2012 Tiny Whale. All rights reserved.
//

#import "ReadLaterOAuth.h"

@implementation ReadLaterOAuth

- (id) initWithConsumerKey: (NSString *) consumerKey consumerSecret: (NSString *) consumerSecret {
    self = [super init];
    if (self) {
        self.consumerKey = consumerKey;
        self.consumerSecret = consumerSecret;
    }
    return self;
}

- (id) initWithConsumerKey: (NSString *) consumerKey consumerSecret: (NSString *) consumerSecret oAuthToken: (NSString *) oAuthToken oAuthSecret: (NSString *) oAuthSecret{
    self = [self initWithConsumerKey: consumerKey consumerSecret: consumerSecret];
    if (self) {
        self.oAuthToken = oAuthToken;
        self.oAuthSecret = oAuthSecret;
    }
    return self;
}

- (void) getTokenForUser: (NSString *) username password: (NSString *)password {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: @"client_auth", @"x_auth_mode", username, @"x_auth_username", password, @"x_auth_password", nil];
    NSURLRequest *request = [ReadLaterSingleton requestForURL: self.tokenURL params:params consumerKey: self.consumerKey consumerSecret: self.consumerSecret oAuthToken:nil oAuthSecret:nil];
    self.requestType = ReadLaterRequestTypeToken;
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest: request delegate:self];
    [connection start];
}

- (void) saveURL: (NSURL *) url {
    self.requestType = ReadLaterRequestTypeBookmark;
    self.url = url;
    NSDictionary *params = [NSDictionary dictionaryWithObject: url.absoluteString forKey: @"url"];
    NSURLRequest *request = [ReadLaterSingleton requestForURL: self.bookmarkURL params: params consumerKey:self.consumerKey consumerSecret: self.consumerSecret oAuthToken: self.oAuthToken oAuthSecret: self.oAuthSecret];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest: request delegate:self];
    [connection start];
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.httpResponse = (NSHTTPURLResponse*)response;
}

@end
