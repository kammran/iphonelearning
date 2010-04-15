//
//  RootViewController.m
//  ATP Calendar
//
//  Created by James Wang on 4/16/10.
//  Copyright DerbySoft 2010. All rights reserved.
//

#import "RootViewController.h"
#import "Context.h"
#import "NSObject-Dialog.h"
#import "UITableView-WithCell.h"
#import "Month2Matches.h"
#import "Match.h"

@implementation RootViewController


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	self.title = @"Month List";
	[super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}


#pragma mark -
#pragma mark Table view data source

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[Context store] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueOrInit:@"FirstLevelCell"];
	NSInteger row = [indexPath row];
	Month2Matches *onemonth = [[Context store] objectAtIndex:row];
	cell.textLabel.text = onemonth.month;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}




#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Month2Matches *onemonth = [[Context store] objectAtIndex:[indexPath row]];
	[onemonth showInDialog];
    
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

