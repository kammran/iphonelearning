//
//  SingleImageController.m
//  Cosplaying
//
//  Created by James Wang on 8/29/10.
//  Copyright 2010 Freeze!. All rights reserved.
//

#import "SingleImageController.h"
#import "NSObject-Dialog.h"

@implementation SingleImageController
@synthesize imageView;
@synthesize uid;
@synthesize image;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.imageView.image = self.image;
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.imageView = nil;
	self.uid = nil;
	self.image = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (void)dealloc {
	[self.imageView release];
	[self.uid release];
	[self.image release];
    [super dealloc];
}

- (IBAction)backToSuperView:(id) sender {
	[self.navigationController popViewControllerAnimated:YES];
}


@end
