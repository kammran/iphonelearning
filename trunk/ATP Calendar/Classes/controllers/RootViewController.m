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
#include <CoreGraphics/CGColor.h>

@implementation RootViewController


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	self.title = @"ATP Tour Calendar";
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


- (void)setMatchesCount: (NSInteger) matchesCount cell: (UITableViewCell *) cell  {
	CGRect matchecCountRect = CGRectMake(200, 15, 70, 15);
	UILabel *matchesCountLabel = [[UILabel alloc] initWithFrame:matchecCountRect];
	
	NSString *matchesCountText = nil;	
	if (matchesCount == 1) {
		matchesCountText = [[NSString alloc] initWithFormat:@"%d Match", matchesCount];
	} else {
		matchesCountText = [[NSString alloc] initWithFormat:@"%d Matches", matchesCount];
	}
	
	matchesCountLabel.text = matchesCountText;
	matchesCountLabel.textAlignment = UITextAlignmentRight;
	matchesCountLabel.font = [UIFont systemFontOfSize:12];
	matchesCountLabel.textColor = [UIColor blueColor];
	[cell.contentView addSubview: matchesCountLabel];
	[matchesCountLabel release];
	[matchesCountText release];
}

- (void) setDetailText: (NSArray *) matches cell: (UITableViewCell *) cell  {
	NSMutableString *detail = [[NSMutableString alloc] init];
	
	for (NSInteger i = 0; i < [matches count]; i++) {
		[detail appendString:[[matches objectAtIndex:i] name]];
		if (i < [matches count] - 1) {
			[detail appendString:@", "];
		}
	}
	
	cell.detailTextLabel.text = detail;
	[detail release];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueOrInit:@"FirstLevelCell" withStyle:UITableViewCellStyleSubtitle];
	Month2Matches *onemonth = [[Context store] objectAtIndex:[indexPath row]];
	cell.textLabel.text = onemonth.month;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	[self setMatchesCount: [onemonth.matches count] cell: cell];
	[self setDetailText: onemonth.matches cell: cell];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 70;
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

