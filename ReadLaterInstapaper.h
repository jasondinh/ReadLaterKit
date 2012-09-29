//
//  ReadLaterInstapaper.h
//  ReadLater
//
//  Created by Jason Dinh on 26/9/12.
//  Copyright (c) 2012 Tiny Whale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReadLaterConfiguration.h"
#import "ReadLaterOAuth.h"

@interface ReadLaterInstapaper : ReadLaterOAuth 

@end

@protocol ReadLaterInstapaperDelegate <NSObject>

- (void) getTokenForInstapaperSuccess: (NSDictionary *) tokenDict;
- (void) getTokenForInstapaperFail: (NSError *) error;

- (void) saveToInstapaperSuccess: (NSURL *) url;
- (void) saveToInstapaperFail:(NSURL *)url error: (NSError *) error;

@end
