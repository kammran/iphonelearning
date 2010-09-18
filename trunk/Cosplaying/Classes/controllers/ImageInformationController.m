//
//  ImageInformationController.m
//  Cosplaying
//
//  Created by Hello Baby on 9/16/10.
//  Copyright 2010 Freeze!. All rights reserved.
//

#import "ImageInformationController.h"
#import "WriteReviewController.h"
#import "UITableView-WithCell.h"
#import "NSObject-Dialog.h"

@implementation ImageInformationController
@synthesize reviewsView;
@synthesize array;

- (void)initializeDataArray {
	self.array = [[NSMutableArray alloc] init];
	[self.array addObject:@"A"];
	[self.array addObject:@"A"];
	[self.array addObject:@"A"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initializeDataArray];
}


- (void)viewDidUnload {
    [super viewDidUnload];
	array = nil;
	reviewsView = nil;
}


- (void)dealloc {
	[array release];
	[reviewsView release];
    [super dealloc];
}

- (IBAction)back {
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)writeReview:(id) sender {
	WriteReviewController *writeReviewController = [[WriteReviewController alloc] initWithNibName:@"WriteReviewController" bundle:nil];
	[self.navigationController pushViewController:writeReviewController animated:YES];
	[writeReviewController release];
}

#pragma mark -
#pragma mark UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return [array count] + 1;
}

- (BOOL)tableView:(UITableView *)tableView isLastRow:(NSIndexPath *)indexPath {
	NSInteger rows = [tableView numberOfRowsInSection:0];
	return [indexPath row] == (rows - 1);		
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueOrInit:@"MatchListCell" withStyle:UITableViewCellStyleSubtitle];
	
	BOOL lastRow = [self tableView:tableView isLastRow:indexPath];
	if (lastRow) {
		//TODO doesn't work
		[cell textLabel].textAlignment = UITextAlignmentCenter;
		cell.textLabel.text = @"More Reviews...";
	} else {
		cell.textLabel.text = [self.array objectAtIndex:[indexPath row]];
	}

	return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	BOOL lastRow = [self tableView:tableView isLastRow:indexPath];
	if (lastRow) {
		int responseCount = 2;
		NSInteger row = [indexPath row] - 1;
		
		NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] initWithCapacity:responseCount];
		
		for (int i = 0; i < responseCount; i++) {
			[self.array addObject:@"Added"];
			[insertIndexPaths addObject:[NSIndexPath indexPathForRow:++row inSection:0]];
		}
			
		[tableView beginUpdates];
		[tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationRight];
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		[tableView endUpdates];
	} else {
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
	}

}

@end
