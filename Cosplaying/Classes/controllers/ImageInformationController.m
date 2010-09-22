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



- (NSArray *) requestNewData:(BOOL) withHeader {
	CosplayingAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	NSString *imageKey = delegate.context.activeImageKey;
	NSString *url = [[NSString stringWithFormat:@"%@/reviews?image_key=%@&with_header=%d&offset=%d", SERVICE_URL, imageKey, withHeader, self.offset] 
					 stringByAddingPercentEscapesUsingEncoding:NSStringEncodingConversionExternalRepresentation];
	
	NSString *response = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
	NSArray *jsonArray = [response JSONValue];
	return jsonArray;
}

- (void)initializeDataArray {
	self.offset = 0;
	self.array = [[NSMutableArray alloc] init];
	[self.array addObjectsFromArray:[self requestNewData:YES]];
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

- (NSString *)mark:(NSString *)source {
	CosplayingAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	NSString *keyword = delegate.context.keyword;
	
	NSRange range = [source rangeOfString:keyword];
	if (range.location == NSNotFound) {
		return source;
	}
	return [source stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"<%@>", keyword]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueOrInit:@"ReviewCell" withStyle:UITableViewCellStyleSubtitle];
	
	BOOL lastRow = [self tableView:tableView isLastRow:indexPath];
	if (lastRow) {
		//TODO doesn't work
		[cell textLabel].textAlignment = UITextAlignmentCenter;
		cell.textLabel.text = @"           More Reviews...";
		cell.detailTextLabel.text = nil;
	} else if ([indexPath row] == 0) {
		NSDictionary *dict = [self.array objectAtIndex:[indexPath row]];
		cell.textLabel.text = [NSString stringWithFormat:@"Average of %@ reviews", [dict valueForKey:@"count"]];
		NSString *detail = [NSString stringWithFormat:@"Average Rate %@\nDate %@", 
							[dict valueForKey:@"average_rate"],
							[dict valueForKey:@"folder"]];
		cell.detailTextLabel.numberOfLines = 2;
		cell.detailTextLabel.text = detail;
	} else {
		NSDictionary *dict = [self.array objectAtIndex:[indexPath row]];
		cell.textLabel.text = [NSString stringWithFormat:@"%D. %@", [indexPath row], [self mark:[dict valueForKey:@"character_name"]]];
		NSString *detail = [NSString stringWithFormat:@"Rate %@ by %@ on %@\nKeywords:%@\n%@", 
							[dict valueForKey:@"rate"],
							[dict valueForKey:@"reviewer"],
							[dict valueForKey:@"created_at"],
							[self mark:[dict valueForKey:@"keywords"]],
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
		NSArray *jsonArray = [self requestNewData:NO];
		[self.array addObjectsFromArray:jsonArray];
		int responseCount = [jsonArray count];		
		if (responseCount == 0) {
			[tableView deselectRowAtIndexPath:indexPath animated:YES];
			return;
		}
		
		NSInteger row = [indexPath row] - 1;
		NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] initWithCapacity:responseCount];
		
		for (int i = 0; i < responseCount; i++) {
			[insertIndexPaths addObject:[NSIndexPath indexPathForRow:++row inSection:0]];
		}
			
		[tableView beginUpdates];
		[tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationBottom];
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		[tableView endUpdates];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 100;
}

@end
