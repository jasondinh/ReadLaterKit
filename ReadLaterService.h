//
//  ReadLaterService.h
//  ReadLater
//
//  Created by Jason Dinh on 28/9/12.
//  Copyright (c) 2012 Tiny Whale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadLaterService : NSObject

@property (weak) id delegate;
@property (strong) NSURL *url;

- (void) saveURL: (NSURL *) url;

@end
