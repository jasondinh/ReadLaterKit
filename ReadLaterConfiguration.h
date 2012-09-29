//
//  ReadLaterKit.h
//  ReadLater
//
//  Created by Jason Dinh on 26/9/12.
//  Copyright (c) 2012 Tiny Whale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+escapeHTML.h"
#import "ReadLaterSingleton.h"

#define INSTAPAPER_TOKEN_URL [NSURL URLWithString: @"https://www.instapaper.com/api/1/oauth/access_token"]
#define INSTAPAPER_BOOKMARK_URL [NSURL URLWithString: @"https://www.instapaper.com/api/1/bookmarks/add"]

#define READABILITY_TOKEN_URL [NSURL URLWithString: @"https://www.readability.com/api/rest/v1/oauth/access_token/"]
#define READABILITY_BOOKMARK_URL [NSURL URLWithString: @"https://www.readability.com/api/rest/v1/bookmarks"]

#define INSTAPAPER_CONSUMER_KEY @""
#define INSTAPAPER_SECRET_KEY @""

#define POCKET_KEY @""

#define READABILITY_CONSUMER_KEY @""
#define READABILITY_SECRET_KEY @""

