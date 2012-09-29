//
//  ReadLaterSingleton.m
//  ReadLater
//
//  Created by Jason Dinh on 28/9/12.
//  Copyright (c) 2012 Tiny Whale. All rights reserved.
//

#import "ReadLaterSingleton.h"

@implementation ReadLaterSingleton

// copy from this answer http://stackoverflow.com/a/756538/305969
+ (NSString *) generateSignatureWithKey:(NSString *)key baseString:(NSString *)baseString {
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [baseString cStringUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
                                          length:sizeof(cHMAC)];
    NSString *hash = [HMAC base64EncodedString];
    return hash;
}


//copy from this answer http://stackoverflow.com/a/2633948/305969
+ (NSString *) genRandStringLength: (int) len {
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}

+ (NSURLRequest *) requestForURL: (NSURL *) url params: (NSDictionary *) params consumerKey: (NSString *) consumerKey consumerSecret: (NSString *) consumerSecret oAuthToken: (NSString *) oAuthToken oAuthSecret: (NSString *) oAuthSecret {
    
    NSMutableString *baseString = [NSMutableString stringWithString: @""];
    NSMutableString *key = [NSMutableString stringWithString: @""];
    
    NSString *nonce = [ReadLaterSingleton genRandStringLength: 20];
    
    NSString *timeStamp = [NSString stringWithFormat: @"%d", (int) [[NSDate date] timeIntervalSince1970]];
    
    NSMutableDictionary *oAuthParams = [NSMutableDictionary dictionary];
    [oAuthParams setValue: consumerKey forKey: @"oauth_consumer_key"];
    [oAuthParams setValue: nonce forKey: @"oauth_nonce"];
    [oAuthParams setValue: @"HMAC-SHA1" forKey: @"oauth_signature_method"];
    [oAuthParams setValue: timeStamp forKey: @"oauth_timestamp"];
    [oAuthParams setValue: @"1.0" forKey: @"oauth_version"];
    
    
    
    if (oAuthToken && ![oAuthToken isEqualToString: @""]) {
        [oAuthParams setValue: oAuthToken forKey: @"oauth_token"];
    }

    NSMutableDictionary *tmpParams = [NSMutableDictionary dictionary];
    NSMutableString *paramsString = [NSMutableString stringWithString: @""];
    NSInteger i = 0;
    for (NSString *key in params) {
        
        if (i != 0) {
            [paramsString appendString: @"&"];
        }
        [paramsString appendFormat: @"%@=%@", key, [params objectForKey:key]];
        [tmpParams setValue: [[params objectForKey: key] escapeHTML] forKey: key];
        i++;
    }
    
    [oAuthParams addEntriesFromDictionary: tmpParams];
    
    NSArray *sortedKeys = [[oAuthParams allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare: obj2];
    }];
    
    [sortedKeys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        if (idx != 0) {
            [baseString appendString: @"&"];
        }
        [baseString appendFormat: @"%@=%@", key, [oAuthParams objectForKey: key]];
    }];
    
    baseString = [NSMutableString stringWithFormat: @"%@&%@&%@", @"POST", [[url absoluteString] escapeHTML], [baseString escapeHTML]];
    
    [key appendFormat: @"%@&", consumerSecret];
    
    if (oAuthSecret && ![oAuthSecret isEqualToString: @""]) {
        [key appendString: oAuthSecret];
    }
    
    NSString *signature = [self generateSignatureWithKey: key baseString:baseString];
    
    NSMutableString *authorizationHeader = [NSMutableString stringWithFormat: @"OAuth oauth_consumer_key=\"%@\", oauth_nonce=\"%@\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"%@\", oauth_version=\"1.0\", oauth_signature=\"%@\"", consumerKey, nonce, timeStamp, signature];
    
    if (oAuthToken && ![oAuthToken isEqualToString: @""]) {
        [authorizationHeader appendFormat: @", oauth_token=\"%@\"", oAuthToken];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url];
    
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [paramsString dataUsingEncoding: NSUTF8StringEncoding]];
    [request setValue: authorizationHeader forHTTPHeaderField: @"Authorization"];
    
    return request;
}

@end
