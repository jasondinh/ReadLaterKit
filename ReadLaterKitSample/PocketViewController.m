//
//  PocketViewController.m
//  ReadLaterKitSample
//
//  Created by Jason Dinh on 29/9/12.
//  Copyright (c) 2012 Tiny Whale. All rights reserved.
//

#import "PocketViewController.h"

@interface PocketViewController ()

@end

@implementation PocketViewController

- (IBAction)saveURLBtnTapped:(id)sender {
    if (!self.readLaterKit) {
        self.readLaterKit = [[ReadLaterKit alloc] init];
        self.readLaterKit.delegate = self;
    }
    self.readLaterKit.pocketUsername = self.username.text;
    self.readLaterKit.pocketPassword = self.password.text;
    [self.readLaterKit saveURL: [NSURL URLWithString: self.url.text] toService: ReadLaterServiceTypePocket];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Pocket";
    }
    return self;
}

- (void) readLaterSaveToPocketSuccess:(NSURL *)url {
    NSString *message = [NSString stringWithFormat: @"Successfully save %@ to Pocket", url.absoluteString];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Pocket" message: message delegate: nil cancelButtonTitle: nil otherButtonTitles: @"Ok", nil];
    [alert show];
}

- (void) readLaterSaveToPocketFail:(NSURL *)url error:(NSError *)error {
    NSString *message = [NSString stringWithFormat: @"Fail to save %@ to Pocket", url.absoluteString];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Pocket" message: message delegate: nil cancelButtonTitle: nil otherButtonTitles: @"Ok", nil];
    [alert show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer: tap];
    // Do any additional setup after loading the view from its nib.
}

- (void) dismissKeyboard: (UITapGestureRecognizer *) tap {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
