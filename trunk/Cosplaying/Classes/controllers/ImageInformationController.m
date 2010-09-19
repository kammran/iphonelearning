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
#import "CosplayingAppDelegate.h"
#import "Configuration.h"
#import "JSON.h"

@implementation ImageInformationController
@synthesize reviewsView;
@synthesize array;
@synthesize offset;



- (NSArray *) requestNewData {
	CosplayingAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	NSString *imageKey = delegate.activeImageKey;
	NSString *url = [[NSString stringWithFormat:@"%@/reviews?image_key=%@&offset=%d", SERVICE_URL, imageKey, self.offset] 
					 stringByAddingPercentEscapesUsingEncoding:NSStringEncodingConversionExternalRepresentation];
	
	
	NSString *response = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
	NSArray *jsonArray = [response JSONValue];
	return jsonArray;
}

- (void)initializeDataArray {
	self.array = [[NSMutableArray alloc] init];
	[self.array addObjectsFromArray:[self requestNewData]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
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
	} else if ([indexPath row] == 0) {
		NSDictionary *dict = [self.array objectAtIndex:[indexPath row]];
		cell.textLabel.text = [NSString stringWithFormat:@"Average of %@ ratings", [dict valueForKey:@"count"]];
		NSString *detail = [NSString stringWithFormat:@"Average Rate %@", [dict valueForKey:@"average_rate"]];
		cell.detailTextLabel.text = detail;
	} else {
		NSDictionary *dict = [self.array objectAtIndex:[indexPath row]];
		cell.textLabel.text = [NSString stringWithFormat:@"%D. %@", [indexPath row], [dict valueForKey:@"character_name"]];
		NSString *detail = [NSString stringWithFormat:@"Rate %@ by %@ on %@\n%@", 
							[dict valueForKey:@"rate"],
							[dict valueForKey:@"reviewer"],
							[dict valueForKey:@"created_at"],
							[dict valueForKey:@"comment"]];
		cell.detailTextLabel.numberOfLines = 5;
		cell.detailTextLabel.text = detail;
	}

	return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate Methods

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	BOOL lastRow = [self tableView:tableView isLastRow:indexPath];
	return lastRow? indexPath : nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	BOOL lastRow = [self tableView:tableView isLastRow:indexPath];
	if (lastRow) {
		self.offset = [self.array count] - 1;
		NSArray *jsonArray = [self requestNewData];
		[self.array addObjectsFromArray:jsonArray];
		int responseCount = [jsonArray count];		
		NSInteger row = [indexPath row] - 1;
		
		NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] initWithCapacity:responseCount];
		
		for (int i = 0; i < responseCount; i++) {
			[insertIndexPaths addObject:[NSIndexPath indexPathForRow:++row inSection:0]];
		}
			
		[tableView beginUpdates];
		[tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationRight];
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		[tableView endUpdates];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 100;
}

@end
