//
//  InstapaperViewController.m
//  ReadLaterKitSample
//
//  Created by Jason Dinh on 29/9/12.
//  Copyright (c) 2012 Tiny Whale. All rights reserved.
//

#import "InstapaperViewController.h"

@interface InstapaperViewController ()

@end

@implementation InstapaperViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Instapaper";
    }
    return self;
}

- (IBAction)saveURLBtnTapped:(id)sender {
    [self.readLaterKit saveURL: [NSURL URLWithString: self.url.text] toService: ReadLaterServiceTypeInstapaper];
}
- (IBAction)getTokenBtnTapped:(id)sender {
    if (!self.readLaterKit) {
        self.readLaterKit = [[ReadLaterKit alloc] init];
        self.readLaterKit.delegate = self;
    }
    
    [self.readLaterKit getInstapaperTokenForUser: self.username.text password: self.password.text];
}

- (void) readLaterGetTokenForInstapaperFail:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Instapaper" message: @"Failed to acquire oAuth token for Instapaper" delegate: nil cancelButtonTitle: nil otherButtonTitles: @"Ok", nil];
    [alert show];
    self.saveURLBtn.enabled = NO;
    self.saveURLBtn.alpha = 0.5;
}

- (void) readLaterGetTokenForInstapaperSuccess {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Instapaper" message: @"OAuth token for Instapaper acquired" delegate: nil cancelButtonTitle: nil otherButtonTitles: @"Ok", nil];
    [alert show];
    
    self.saveURLBtn.enabled = YES;
    self.saveURLBtn.alpha = 1;
}

- (void) readLaterSaveToInstapaperSuccess:(NSURL *)url {
    NSString *message = [NSString stringWithFormat: @"Successfully save %@ to Instapaper", url.absoluteString];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Instapaper" message: message delegate: nil cancelButtonTitle: nil otherButtonTitles: @"Ok", nil];
    [alert show];
}

- (void) readLaterSaveToInstapaperFail:(NSURL *)url error:(NSError *)error {
    NSString *message = [NSString stringWithFormat: @"Fail to save %@ to Instapaper", url.absoluteString];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Instapaper" message: message delegate: nil cancelButtonTitle: nil otherButtonTitles: @"Ok", nil];
    [alert show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer: tap];
    self.saveURLBtn.enabled = NO;
    self.saveURLBtn.alpha = 0.5;
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
