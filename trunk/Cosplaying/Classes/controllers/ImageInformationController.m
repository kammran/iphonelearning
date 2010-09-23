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
#import "RatingCellView.h"

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
	[self.reviewsView reloadData];
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
	UITableViewCell *cell = nil;
	
	NSUInteger row = [indexPath row];
	BOOL lastRow = [self tableView:tableView isLastRow:indexPath];
	if (lastRow) {
		cell = [tableView dequeueOrInit:@"MoreReviewsCell" withStyle:UITableViewCellStyleSubtitle];
		[cell textLabel].textAlignment = UITextAlignmentCenter;
		cell.textLabel.text = @"           More Reviews...";
		cell.detailTextLabel.text = nil;
	} else if (row == 0) {
		cell = [tableView dequeueOrInit:@"HeaderCell" withStyle:UITableViewCellStyleSubtitle];

		NSDictionary *dict = [self.array objectAtIndex:row];
		
		UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
		date.text = [NSString stringWithFormat:@"Upload date %@", [dict valueForKey:@"folder"]];
		[cell.contentView addSubview:date];
		[date release];
		
		UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 300, 20)];
		title.text = [NSString stringWithFormat:@"Average of %@ ratings", [dict valueForKey:@"count"]];
		[cell.contentView addSubview:title];
		[title release];
		
		RatingCellView *ratingCellView = [[RatingCellView alloc] initWithFrame:CGRectMake(10, 50, 50, 20)];
		ratingCellView.rating = [[dict valueForKey:@"average_rate"] floatValue];
		[cell.contentView addSubview:ratingCellView];
		[ratingCellView release];
	} else {
		cell = [tableView dequeueOrInit:@"ReviewCell" withStyle:UITableViewCellStyleSubtitle];
		NSDictionary *dict = [self.array objectAtIndex:row];
		
		UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
		title.text = [NSString stringWithFormat:@"%D. %@", [indexPath row], [self mark:[dict valueForKey:@"character_name"]]];
		[cell.contentView addSubview:title];
		[title release];

		RatingCellView *ratingCellView = [[RatingCellView alloc] initWithFrame:CGRectMake(10, 30, 50, 20)];
		ratingCellView.rating = [[dict valueForKey:@"rate"] floatValue];
		[cell.contentView addSubview:ratingCellView];
		[ratingCellView release];

		UILabel *reviewer = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 300, 20)];
		reviewer.text = [NSString stringWithFormat:@"by %@ at %@", 
						 [self mark:[dict valueForKey:@"reviewer"]],
						 [dict valueForKey:@"created_at"]];
		reviewer.textColor = [UIColor grayColor];
		reviewer.font = [UIFont systemFontOfSize:12]; 
		[cell.contentView addSubview:reviewer];
		[reviewer release];
		
		UILabel *keywords = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 300, 20)];
		keywords.text = [NSString stringWithFormat:@"Keywords: %@", [dict valueForKey:@"keywords"]];
		keywords.textColor = [UIColor grayColor];
		keywords.font = [UIFont systemFontOfSize:12]; 
		[cell.contentView addSubview:keywords];
		[keywords release];
		
	
		UILabel *comment = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 300, 20)];
		comment.numberOfLines = 5; 
		comment.text = [dict valueForKey:@"comment"];
		comment.textColor = [UIColor grayColor];
		comment.font = [UIFont systemFontOfSize:12]; 
		[cell.contentView addSubview:comment];
		[comment release];
		
		if (row % 2 == 1) {
			UIColor *color = [[UIColor alloc] initWithRed:0.6 green:0.8	blue:0.8 alpha:1.0];
			cell.textLabel.backgroundColor = color;
			cell.contentView.backgroundColor = color;
			cell.detailTextLabel.backgroundColor = color;			
			[color release];
		} 
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
		if (self.offset < 0) {
			self.offset = 0;
		}
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
	int row = [indexPath row];
	if (row == 0) {
		return 80;
	}
	return 100;
}

@end
