//
//  ReadLaterPocket.h
//  ReadLater
//
//  Created by Jason Dinh on 26/9/12.
//  Copyright (c) 2012 Tiny Whale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReadLaterConfiguration.h"
#import "ReadLaterService.h"
@interface ReadLaterPocket : ReadLaterService <NSURLConnectionDataDelegate>

@property (strong) NSString *username;
@property (strong) NSString *password;

- (id) initWithUsername: (NSString *) username password: (NSString *) password;

@end

@protocol ReadLaterPocketDelegate <NSObject>

- (void) saveToPocketSuccess: (NSURL *) url;
- (void) saveToPocketFail:(NSURL *)url error: (NSError *) error;

@end
