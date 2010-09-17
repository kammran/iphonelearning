//
//  WriteReviewController.m
//  Cosplaying
//
//  Created by Hello Baby on 9/16/10.
//  Copyright 2010 Freeze!. All rights reserved.
//

#import "WriteReviewController.h"
#import "NSObject-Dialog.h"


@implementation WriteReviewController
@synthesize characterNameTextField;
@synthesize keyworldsTextField;
@synthesize reviewTextView;


#pragma mark -
#pragma mark ViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewDidUnload {
    [super viewDidUnload];
	characterNameTextField = nil;
	keyworldsTextField = nil;
	reviewTextView = nil;
}


- (void)dealloc {
    [super dealloc];
	[characterNameTextField release];
	[keyworldsTextField release];
	[reviewTextView release];
}

#pragma mark -
#pragma mark IBAction Methods

- (IBAction)back {
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendReview {

	
	
}

@end
