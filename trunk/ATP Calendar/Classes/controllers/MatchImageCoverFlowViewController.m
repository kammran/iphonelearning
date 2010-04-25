    //
//  MatchImageCoverFlowViewController.m
//  ATP Calendar
//
//  Created by Hello Baby on 4/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MatchImageCoverFlowViewController.h"
#import "FlowCoverView.h"
#import "Match.h"

@implementation MatchImageCoverFlowViewController
@synthesize match;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark -
#pragma mark Autororate Methods
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return interfaceOrientation == UIInterfaceOrientationLandscapeRight;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.match = nil;
}


- (void)dealloc {
	[self.match release];
    [super dealloc];
}

#pragma mark -
#pragma mark FlowCoverView Delegate Methods

- (int)flowCoverNumberImages:(FlowCoverView *)view
{
	return 10;
}

- (UIImage *)flowCover:(FlowCoverView *)view cover:(int)index
{
	NSString *imageName = [[NSString alloc] initWithFormat:@"%@-%d.png", match.name, index];
	UIImage *image = [UIImage imageNamed:imageName];
	[imageName release];
	return image;
}

- (void)flowCover:(FlowCoverView *)view didSelect:(int)index
{
	NSLog(@"Selected Index %d", index);
}

@end
