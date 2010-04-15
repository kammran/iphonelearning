//
//  ATP_CalendarAppDelegate.m
//  ATP Calendar
//
//  Created by James Wang on 4/16/10.
//  Copyright DerbySoft 2010. All rights reserved.
//

#import "ATP_CalendarAppDelegate.h"
#import "RootViewController.h"
#import "Month2Matches.h"
#import "Match.h"

@implementation ATP_CalendarAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize store;

- (void)initStore {
	Match *dubai = [[Match alloc] initWithName:@"dubai" date:nil city:nil website:nil introduction:nil];
	NSArray *januaryMatches = [[NSArray alloc] initWithObjects:dubai, nil];
	Month2Matches *january = [[Month2Matches alloc] initWithMonth:@"January" matches:januaryMatches];
	Match *maimi = [[Match alloc] initWithName:@"maimi" date:nil city:nil website:nil introduction:nil];
	NSArray *februraryMatches = [[NSArray alloc] initWithObjects:maimi, nil];
	Month2Matches *februrary = [[Month2Matches alloc] initWithMonth:@"February" matches:februraryMatches];
	self.store = [[NSArray alloc] initWithObjects:january, februrary, nil];
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
	
	[self initStore];
	
	return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[store release];
	[super dealloc];
}


@end

