//
//  PocketViewController.h
//  ReadLaterKitSample
//
//  Created by Jason Dinh on 29/9/12.
//  Copyright (c) 2012 Tiny Whale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadLaterKit.h"
@interface PocketViewController : UIViewController <ReadLaterDelegate>

@property (strong) ReadLaterKit *readLaterKit;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *url;
- (IBAction)saveURLBtnTapped:(id)sender;

@end
