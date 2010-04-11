//
//  SectionsViewController.m
//  Sections
//
//  Created by James Wang on 4/11/10.
//  Copyright DerbySoft 2010. All rights reserved.
//

#import "SectionsViewController.h"

@implementation SectionsViewController
@synthesize names;
@synthesize keys;



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
	NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
	self.names = dict;
	[dict release];
	self.keys = [[self.names allKeys] sortedArrayUsingSelector:@selector(compare:)];
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.names = nil;
	self.keys = nil;
}


- (void)dealloc {
	[self.names release];
	[self.keys release];
    [super dealloc];
}

#pragma mark -
#pragma mark UITableView Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self.keys count];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	NSString *key = [self.keys objectAtIndex:section];
	return [[self.names objectForKey:key] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *key = [self.keys objectAtIndex:[indexPath section]];
	NSInteger row = [indexPath row];
	NSString *name = [[self.names objectForKey:key] objectAtIndex:row];
	
	NSString *SectionTableIdentifier = @"SectionTableViewIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SectionTableIdentifier];
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SectionTableIdentifier];
	}
	
	cell.textLabel.text = name;
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [self.keys objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	return keys;
}

@end
