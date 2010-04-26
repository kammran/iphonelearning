//
//  MatchImageFlowCoverViewDelegate.m
//  ATP Calendar
//
//  Created by James Wang on 4/27/10.
//  Copyright 2010 DerbySoft. All rights reserved.
//

#import "MatchImageFlowCoverViewDelegate.h"


@implementation MatchImageFlowCoverViewDelegate
@synthesize matchName;


#pragma mark -
#pragma mark FlowCoverView Delegate Methods

- (int)flowCoverNumberImages:(FlowCoverView *)view
{
	return 10;
}

- (UIImage *)flowCover:(FlowCoverView *)view cover:(int)index
{
	NSArray *supportedTypes = [[NSArray alloc] initWithObjects:@".png", @".jpg", nil];
	UIImage *image = nil;
	
	for (id type in supportedTypes) {
		NSString *imageName = [[NSString alloc] initWithFormat:@"%@-%d%@", matchName, index, type];
		image = [UIImage imageNamed:imageName];
		[imageName release];
		if (image) {
			break;
		}
	}
	
	[supportedTypes release];
	if (!image) {
		NSLog(@"Couldn't load image of %@-%d", matchName, index);
	}
	return image;
}

- (void)flowCover:(FlowCoverView *)view didSelect:(int)index
{
	//NSLog(@"Selected Index %d", index);
}

- (void) dealloc {
	[matchName release];
	[super dealloc];
}

@end
