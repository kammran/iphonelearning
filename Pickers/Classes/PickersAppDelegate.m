//
//  PickersAppDelegate.m
//  Pickers
//
//  Created by Hello Baby on 3/31/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "PickersAppDelegate.h"

@implementation PickersAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
