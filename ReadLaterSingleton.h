//
//  ReadLaterSingleton.h
//  ReadLater
//
//  Created by Jason Dinh on 28/9/12.
//  Copyright (c) 2012 Tiny Whale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSData+Base64.h"
#import "NSString+escapeHTML.h"
@interface ReadLaterSingleton : NSObject

+ (NSURLRequest *) requestForURL: (NSURL *) url params: (NSDictionary *) params consumerKey: (NSString *) consumerKey consumerSecret: (NSString *) consumerSecret oAuthToken: (NSString *) oAuthToken oAuthSecret: (NSString *) oAuthSecret;

+ (NSString *) generateSignatureWithKey:(NSString *)key baseString:(NSString *)baseString;
+ (NSString *) genRandStringLength: (int) len;
@end
