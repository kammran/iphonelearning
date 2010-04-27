//
//  MatchImageFlowCoverViewDelegate.m
//  ATP Calendar
//
//  Created by James Wang on 4/27/10.
//  Copyright 2010 DerbySoft. All rights reserved.
//

#import "MatchImageFlowCoverViewDelegate.h"


@implementation MatchImageFlowCoverViewDelegate
@synthesize images;

- (void)initImages {
	[self.images release];
	self.images = nil;
	self.images = [[NSMutableDictionary alloc] initWithCapacity:kMaxImagesCount];
	
	NSArray *supportedTypes = [[NSArray alloc] initWithObjects:@".png", @".jpg", nil];
	
	for (int i = 0; i < kMaxImagesCount; i++) {
		UIImage *image = nil;
		
		for (id type in supportedTypes) {
			NSString *imageName = [[NSString alloc] initWithFormat:@"%@-%d%@", matchName, i, type];
			image = [UIImage imageNamed:imageName];
			[imageName release];
			if (image) {
				[self.images setObject:image forKey:[NSString stringWithFormat:@"%d", i]];
				break;
			}
		}
	}

	[supportedTypes release];
}


- (void)setMatchName:(NSString *)theMatchName {
	matchName = theMatchName;
	[self initImages];
}

- (NSString *)matchName {
	return matchName;
}

#pragma mark -
#pragma mark FlowCoverView Delegate Methods

- (int)flowCoverNumberImages:(FlowCoverView *)view
{
	return [[self.images allKeys] count];
}

- (UIImage *)flowCover:(FlowCoverView *)view cover:(int)index
{
	UIImage *image = [self.images valueForKey:[NSString stringWithFormat:@"%d", index]];
	if (!image) {
		NSLog(@"Couldn't load image for %@-%d", matchName, index);
	}
	return image;
}

- (void)flowCover:(FlowCoverView *)view didSelect:(int)index
{
	//NSLog(@"Selected Index %d", index);
}

- (void) dealloc {
	[images release];
	[matchName release];
	[super dealloc];
}

@end
