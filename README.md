ReadLaterKit
============

`ReadLaterKit` provides a simple API to save URL(s) to "read later" services'.

To use it in Xcode:

1. Copy all the files in `ReadLaterKit` group into your Xcode project
2. Add `Security.framework`
3. Include `ReadLaterKit.h`
4. Fill in your API key & secret in `ReadLaterConfiguration.h`

For `Pocket`:

	ReadLaterKit *readLaterKit = [[ReadLaterKit alloc] init];
	readLaterKit.delegate = self; //optional
	readLaterKit.pocketUsername = POCKET_USERNAME;
	readLaterKit.pocketPassword = POCKET_PASSWORD
	
	//save URL:
	[readLaterKit saveURL: URL toService: ReadLaterServiceTypePocket];
	
For `Instapaper`:
	
	//Instapaper supports XAuth for authentication, thus you don't need to
	//remember username/password. Please discard them as soon as you retrieve
	//the token & secret and use them instead. It's also your responsibility 
	//to save the token & secret for later usage
	
	ReadLaterKit *readLaterKit = [[ReadLaterKit alloc] init];
	readLaterKit.delegate = self; //optional
	[readLaterKit getInstapaperTokenForUser: INSTAPAPER_USERNAME password: INSTAPAPER_PASSWORD];
	
	//after delegate callback readLaterGetTokenForInstapaperSuccess
	[readLaterKit saveURL: URL toService: ReadLaterServiceTypeInstapaper];
	//token & secret can be accessed in your ReadLaterKit instance: readLaterKit.instapaperOAuthToken & readLaterKit.instapaperOAuthSecret
	
`Readability` is similar to `Instapaper`. 

`ReadLaterKit` supports `ReadLaterDelegate` with callback after a token 
request is succeeded/failed and a save request is succeeded/failed:

	- (void) readLaterGetTokenForInstapaperSuccess;
	- (void) readLaterGetTokenForInstapaperFail: (NSError *) error;

	- (void) readLaterSaveToInstapaperSuccess: (NSURL *) url;
	- (void) readLaterSaveToInstapaperFail:(NSURL *)url error: (NSError *) error;

	- (void) readLaterSaveToPocketSuccess: (NSURL *) url;
	- (void) readLaterSaveToPocketFail:(NSURL *)url error: (NSError *) error;

	- (void) readLaterGetTokenForReadabilitySuccess;
	- (void) readLaterGetTokenForReadabilityFail: (NSError *) error;

	- (void) readLaterSaveToReadabilitySuccess: (NSURL *) url;
	- (void) readLaterSaveToReadabilityFail:(NSURL *)url error: (NSError *) error;
	
To add more service with oAuth/xAuth support, look into `ReadLaterOAuth` class.

##LICENSE##

============

ReadLaterKit is available under the MIT license. See the LICENSE file for more 
info.