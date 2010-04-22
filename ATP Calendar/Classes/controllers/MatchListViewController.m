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
#import "MatchImageCoverFlowViewController.h"

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
	cell.imageView.image = [match categoryImage];
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (Match *) match: (NSIndexPath *) indexPath  {
	return [matches objectAtIndex:[indexPath row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Match *match = [self match: indexPath];
	MatchDetailViewController *detailViewController = [[MatchDetailViewController alloc] initWithNibName:@"MatchDetailView" bundle:nil];
	detailViewController.title = match.name;
	detailViewController.match = match;
	UIScrollView *view = (UIScrollView *) detailViewController.view;
	view.scrollEnabled = YES;
	[view setContentSize:CGSizeMake(320, 460)];
	[self.navigationController pushViewController:detailViewController animated:YES];
	[detailViewController release];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	MatchImageCoverFlowViewController *coverFlowController = [[MatchImageCoverFlowViewController alloc] initWithNibName:@"MatchImageCoverFlowView" bundle:nil];
	Match *match = [self match: indexPath];
	coverFlowController.match = match;
	NSString *title = [[NSString alloc] initWithFormat:@"Pictures of %@", match.name];
	coverFlowController.title = title;
	[title release];
	[self.navigationController pushViewController:coverFlowController animated:YES];
	[coverFlowController release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80;
}

- (void)dealloc {
    [super dealloc];
}




@end
