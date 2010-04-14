//
//  DisclosureButtonController.m
//  Nav
//
//  Created by Hello Baby on 4/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DisclosureButtonController.h"
#import "DisclosureDetailController.h"

@implementation DisclosureButtonController
@synthesize list;

- (void)viewDidLoad {
	NSArray *array = [[NSArray alloc] initWithObjects:@"Toy Story", @"A Bug's Life", @"Toy Story 2", @"Monsters, Inc.",
					  @"Finding Nemo", @"The Incredibles", @"Cars", @"Ratatouille", @"WALL-E", @"Up", @"Toy Story 3", @"Cars 2", @"The Bear and the Bow", @"Newt", nil];
	
	self.list = array;
	[array release];
	[super viewDidLoad];
}

- (void)viewDidUnload {
	list = nil;
	detailController = nil;
	[super viewDidUnload];
}

- (void)dealloc {
	[list release];
	[detailController release];
	[super dealloc];
}

#pragma mark -
#pragma mark UITableView DataSource Methods

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return [self.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *DisclosureButtonIdentier = @"DisclosureButtonIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DisclosureButtonIdentier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DisclosureButtonIdentier] autorelease];
	}
							 
	cell.textLabel.text = [self.list objectAtIndex:[indexPath row]];
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	return cell;
}

@end
