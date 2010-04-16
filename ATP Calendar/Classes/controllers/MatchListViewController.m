//
//  MatchListViewController.m
//  ATP Calendar
//
//  Created by Hello Baby on 4/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MatchListViewController.h"
#import "Context.h"
#import "UITableView-WithCell.h"
#import "Match.h"
#import "MatchDetailViewController.h"

@implementation MatchListViewController
@synthesize matches;

- (void)viewDidLoad {

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}


#pragma mark -
#pragma mark UITableView DataSource Methods
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return [matches count]; 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueOrInit:@"MatchListCell" withStyle:UITableViewCellStyleSubtitle];
	Match * match = [matches objectAtIndex:[indexPath row]];
	cell.textLabel.text = match.name;
	NSString *detail = [[NSString alloc] initWithFormat:@"%@ %@, %@", match.date, match.city, match.country];
	cell.detailTextLabel.text = detail;
	[detail release];
	NSString * imageName = [[NSString alloc] initWithFormat:@"%@.png", match.level];
	cell.imageView.image = [UIImage imageNamed:imageName];
	[imageName release];
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Match *match = [matches objectAtIndex:[indexPath row]];
	MatchDetailViewController *detailViewController = [[MatchDetailViewController alloc] initWithNibName:@"MatchDetailView" bundle:nil];
	detailViewController.match = match;
	[self.navigationController pushViewController:detailViewController animated:YES];
	[detailViewController release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80;
}

- (void)dealloc {
    [super dealloc];
}




@end
