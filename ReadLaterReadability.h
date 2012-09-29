//
//  ReadLaterReadability.h
//  ReadLater
//
//  Created by Jason Dinh on 26/9/12.
//  Copyright (c) 2012 Tiny Whale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReadLaterOAuth.h"
@interface ReadLaterReadability : ReadLaterOAuth

@end

@protocol ReadLaterReadabilityDelegate <NSObject>
- (void) getTokenForReadabilitySuccess: (NSDictionary *)tokenDict;
- (void) getTokenForReadabilityFail: (NSError *) error;

- (void) saveToReadabilitySuccess: (NSURL *) url;
- (void) saveToReadabilityFail:(NSURL *)url error: (NSError *) error;

@end
