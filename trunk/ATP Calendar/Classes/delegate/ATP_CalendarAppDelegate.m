//
//  ATP_CalendarAppDelegate.m
//  ATP Calendar
//
//  Created by James Wang on 4/16/10.
//  Copyright DerbySoft 2010. All rights reserved.
//

#import "ATP_CalendarAppDelegate.h"
#import "RootViewController.h"
#import "ResourceLoader.h"

@implementation ATP_CalendarAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize store;
@synthesize matchImageFlowCoverViewDelegate;

- (void)initStore {
	self.store = [ResourceLoader loadData];
}

- (void)initMatchImageFlowCoverViewDelegate {
	self.matchImageFlowCoverViewDelegate = [[MatchImageFlowCoverViewDelegate alloc] init];
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
	[self initStore];
	[self initMatchImageFlowCoverViewDelegate];
	
	return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[matchImageFlowCoverViewDelegate release];
	[navigationController release];
	[window release];
	[store release];
	[super dealloc];
}


@end

