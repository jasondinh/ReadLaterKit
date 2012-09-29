//
//  ReadabilityViewController.m
//  ReadLaterKitSample
//
//  Created by Jason Dinh on 29/9/12.
//  Copyright (c) 2012 Tiny Whale. All rights reserved.
//

#import "ReadabilityViewController.h"

@interface ReadabilityViewController ()

@end

@implementation ReadabilityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Readability";
    }
    return self;
}

- (IBAction)saveURLBtnTapped:(id)sender {
    [self.readLaterKit saveURL: [NSURL URLWithString: self.url.text] toService: ReadLaterServiceTypeReadability];
}
- (IBAction)getTokenBtnTapped:(id)sender {
    if (!self.readLaterKit) {
        self.readLaterKit = [[ReadLaterKit alloc] init];
        self.readLaterKit.delegate = self;
    }
    [self.readLaterKit getReadabilityTokenForUser:self.username.text password:self.password.text];
}

- (void) readLaterGetTokenForReadabilityFail:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Readability" message: @"Failed to acquire oAuth token for Readability" delegate: nil cancelButtonTitle: nil otherButtonTitles: @"Ok", nil];
    [alert show];
    self.saveURLBtn.enabled = NO;
    self.saveURLBtn.alpha = 0.5;
}

- (void) readLaterGetTokenForReadabilitySuccess {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Readability" message: @"OAuth token for Readability acquired" delegate: nil cancelButtonTitle: nil otherButtonTitles: @"Ok", nil];
    [alert show];
    
    self.saveURLBtn.enabled = YES;
    self.saveURLBtn.alpha = 1;
}

- (void) readLaterSaveToReadabilitySuccess:(NSURL *)url {
    NSString *message = [NSString stringWithFormat: @"Successfully save %@ to Readability", url.absoluteString];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Readability" message: message delegate: nil cancelButtonTitle: nil otherButtonTitles: @"Ok", nil];
    [alert show];
}

- (void) readLaterSaveToReadabilityFail:(NSURL *)url error:(NSError *)error {
    NSString *message = [NSString stringWithFormat: @"Fail to save %@ to Readability", url.absoluteString];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Readability" message: message delegate: nil cancelButtonTitle: nil otherButtonTitles: @"Ok", nil];
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
