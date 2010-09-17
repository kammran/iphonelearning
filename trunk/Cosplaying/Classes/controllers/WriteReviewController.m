//
//  WriteReviewController.m
//  Cosplaying
//
//  Created by Hello Baby on 9/16/10.
//  Copyright 2010 Freeze!. All rights reserved.
//

#import "WriteReviewController.h"
#import "NSObject-Dialog.h"
#import "ASIFormDataRequest.h"
#import "Configuration.h"

@implementation WriteReviewController
@synthesize rateSegment;
@synthesize characterNameTextField;
@synthesize keywordsTextField;
@synthesize reviewTextView;


#pragma mark -
#pragma mark ViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewDidUnload {
    [super viewDidUnload];
	rateSegment = nil;
	characterNameTextField = nil;
	keywordsTextField = nil;
	reviewTextView = nil;
}


- (void)dealloc {
    [super dealloc];
	[rateSegment release];
	[characterNameTextField release];
	[keywordsTextField release];
	[reviewTextView release];
}

#pragma mark -
#pragma mark IBAction Methods

- (IBAction)back {
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendReview {
	NSString *rate = [NSString stringWithFormat:@"%d", [self.rateSegment selectedSegmentIndex] + 1];
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/reviews", SERVICE_URL]];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request addPostValue:rate forKey:@"rate"];
	[request addPostValue:self.characterNameTextField.text forKey:@"character_name"];
	[request addPostValue:self.keywordsTextField.text forKey:@"keywords"];
	[request addPostValue:self.reviewTextView.text forKey:@"review"];
	[request startSynchronous];
	NSError *error = [request error];
	if (!error) {
		NSString *response = [request responseString];
		[response showInDialog];
	} else {
		[error showInDialogWithTitle:@"Oops, Error"];
	}
	
}

@end
