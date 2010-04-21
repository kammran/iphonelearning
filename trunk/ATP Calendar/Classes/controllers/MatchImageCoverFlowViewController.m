    //
//  MatchImageCoverFlowViewController.m
//  ATP Calendar
//
//  Created by Hello Baby on 4/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MatchImageCoverFlowViewController.h"


@implementation MatchImageCoverFlowViewController
@synthesize imageView;
@synthesize match;

- (void)loadImages {
	UIImage *image1 = [UIImage imageNamed:@"Default.png"];
	UIImage *image2 = [UIImage imageNamed:@"Brisbane.jpg"];
	NSArray *images = [[NSArray alloc] initWithObjects:image1, image2, nil];
//	self.imageView = [[UIImageView alloc] initWithImage:image2];
	//self.imageView.image = image1;
	self.imageView.animationImages = images;
	self.imageView.animationDuration = 5;
	[self.imageView startAnimating];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[self loadImages];
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.imageView = nil;
	self.match = nil;
}


- (void)dealloc {
	[self.imageView release];
	[self.match release];
    [super dealloc];
}


@end
