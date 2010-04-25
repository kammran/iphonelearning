//
//  NSObject-Dialog.m
//  ATP Calendar
//
//  Created by James Wang on 4/16/10.
//  Copyright 2010 DerbySoft. All rights reserved.
//

#import "NSObject-Dialog.h"


@implementation NSObject (Dialog)

-(void)showInDialog {
	NSString *message = [[NSString alloc] initWithFormat:@"%@", self];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" 
													message:message 
												   delegate:nil 
										  cancelButtonTitle:@"Ok" 
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
	[message release];
}

@end
