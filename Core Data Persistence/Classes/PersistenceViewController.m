//
//  PersistenceViewController.m
//  Core Data Persistence
//
//  Created by Hello Baby on 8/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PersistenceViewController.h"
#import "Core_Data_PersistenceAppDelegate.h"

@implementation PersistenceViewController
@synthesize line1;
@synthesize line2;
@synthesize line3;
@synthesize line4;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	Core_Data_PersistenceAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context = [delegate managedObjectContext];
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Line" inManagedObjectContext:context];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	NSError *error;
	NSArray *objects = [context executeFetchRequest:request error:&error];
	if (objects == nil) {
		NSLog(@"There was an error : %@", error); 
	}
	
	for (NSManagedObject *oneObject in objects) {
		NSNumber *lineNum = [oneObject valueForKey:@"LineNum"];
		NSString *lineText = [oneObject valueForKey:@"LineText"];
		
		UITextField *textField = [self valueForKey:[NSString stringWithFormat:@"line%@", lineNum]];
		textField.text = lineText;
	}
	
	
	[request release];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(applicationWillTerminate:) 
												 name:UIApplicationWillTerminateNotification
											   object:[UIApplication sharedApplication]];
	
	
    [super viewDidLoad];
}

- (void)applicationWillTerminate:(NSNotification *) notification {
	Core_Data_PersistenceAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context = [delegate managedObjectContext];
	NSError *error;
	
	for (int i = 1; i <= 4; i++) {
		NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Line" inManagedObjectContext:context];
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		[request setEntity:entityDescription];	
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"lineNum=%d", i];
		[request setPredicate:predicate];
		
		NSManagedObject *theLine = nil;
		NSArray *objects = [context executeFetchRequest:request error:&error];
		if (objects == nil) {
			NSLog(@"There was an error : %@", error); 
		}
		if ([objects count] > 0) {
			theLine = [objects objectAtIndex:0];
		} else {
			theLine = [NSEntityDescription insertNewObjectForEntityForName:@"Line" inManagedObjectContext:context];
		}
		
		UITextField *textField = [self valueForKey:[NSString stringWithFormat: @"line%d", i]];
		
		[theLine setValue:[NSNumber numberWithInt:i] forKey:@"LineNum"];
		[theLine setValue:textField.text forKey:@"LineText"];
		
		[request release];
	}
	
	[context save:&error];
}

- (void)viewDidUnload {
	self.line1 = nil;
	self.line2 = nil;
	self.line3 = nil;
	self.line4 = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[self.line1 release];
	[self.line2 release];
	[self.line3 release];
	[self.line4 release];
    [super dealloc];
}


@end
