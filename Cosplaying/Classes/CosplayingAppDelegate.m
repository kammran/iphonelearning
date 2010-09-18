//
//  CosplayingAppDelegate.m
//  Cosplaying
//
//  Created by James Wang on 8/28/10.
//  Copyright DerbySoft 2010. All rights reserved.
//

#import "CosplayingAppDelegate.h"
#import "ImagesPreviewController.h"

@implementation CosplayingAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize activeImageKey;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	[window addSubview:navigationController.view];
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
    [window makeKeyAndVisible];
	
	return YES;
}

- (void)dealloc {
	[activeImageKey release];
	[navigationController release];
    [window release];
    [super dealloc];
}


@end
