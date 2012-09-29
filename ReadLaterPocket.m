//
//  ReadLaterPocket.m
//  ReadLater
//
//  Created by Jason Dinh on 26/9/12.
//  Copyright (c) 2012 Tiny Whale. All rights reserved.
//

#import "ReadLaterPocket.h"

@implementation ReadLaterPocket

- (id) initWithUsername: (NSString *) username password: (NSString *) password {
    self = [super init];
    if (self) {
        self.username = username;
        self.password = password;
    }
    return self;
}

- (void) saveURL: (NSURL *) url {
    self.url = url;
    NSString *params = [NSString stringWithFormat: @"username=%@&password=%@&apikey=%@&url=%@", self.username, self.password , POCKET_KEY, url.absoluteString];
    
    NSURL *apiEndPoint = [NSURL URLWithString: @"https://readitlaterlist.com/v2/add"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: apiEndPoint];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [params dataUsingEncoding: NSUTF8StringEncoding]];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest: request delegate: self];
    [connection start];
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int code = [httpResponse statusCode];
    
    if (code == 200) {
        if (self.delegate && [self.delegate respondsToSelector: @selector(saveToPocketSuccess:)]) {
            [self.delegate saveToPocketSuccess: self.url];
        }
    }
    else {
        if (self.delegate && [self.delegate respondsToSelector: @selector(saveToPocketFail:error:)]) {
            NSError *error;
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            
            switch (code) {
                case 400:
                    [errorDetail setValue:@"Invalid request, please make sure you follow the documentation for proper syntax" forKey:NSLocalizedDescriptionKey];
                    break;
                case 401:
                    [errorDetail setValue:@"Username and/or password is incorrect" forKey:NSLocalizedDescriptionKey];
                    break;
                case 403:
                    [errorDetail setValue:@"Rate limit exceeded, please wait a little bit before resubmitting" forKey:NSLocalizedDescriptionKey];
                    break;
                case 503:
                    [errorDetail setValue:@"Pocket's sync server is down for scheduled maintenance" forKey:NSLocalizedDescriptionKey];
                    break;
                default:
                    [errorDetail setValue:@"Unknown error" forKey:NSLocalizedDescriptionKey];
                    break;
            }
            error = [NSError errorWithDomain: @"Pocket" code: code userInfo:errorDetail];
            [self.delegate saveToPocketFail: self.url error: error];
        }
    }
}

@end
