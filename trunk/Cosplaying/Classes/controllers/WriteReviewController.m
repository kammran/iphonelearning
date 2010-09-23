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
#import "CosplayingAppDelegate.h"

@implementation WriteReviewController
@synthesize ratingView;
@synthesize reviewerTextField;
@synthesize characterNameTextField;
@synthesize keywordsTextField;
@synthesize commentTextView;
@synthesize sendButton;


#pragma mark -
#pragma mark ViewController Methods

- (void) initRatingView {
	[ratingView setStarImage:[UIImage imageNamed:@"star-halfselected.png"] forState:kSCRatingViewHalfSelected];
	[ratingView setStarImage:[UIImage imageNamed:@"star-highlighted.png"] forState:kSCRatingViewHighlighted];
	[ratingView setStarImage:[UIImage imageNamed:@"star-hot.png"] forState:kSCRatingViewHot];
	[ratingView setStarImage:[UIImage imageNamed:@"star-nonselected.png"] forState:kSCRatingViewNonSelected];
	[ratingView setStarImage:[UIImage imageNamed:@"star-selected.png"] forState:kSCRatingViewSelected];
	[ratingView setStarImage:[UIImage imageNamed:@"star-userselected.png"] forState:kSCRatingViewUserSelected];
	ratingView.userRating = 3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initRatingView];
}


- (void)viewDidUnload {
    [super viewDidUnload];
	ratingView = nil;
	reviewerTextField = nil;
	characterNameTextField = nil;
	keywordsTextField = nil;
	commentTextView = nil;
	sendButton = nil;
}


- (void)dealloc {
    [super dealloc];
	[ratingView release];
	[reviewerTextField release];
	[characterNameTextField release];
	[keywordsTextField release];
	[commentTextView release];
	[sendButton release];
}

#pragma mark -
#pragma mark IBAction Methods

- (IBAction)back {
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendReview {
	NSString *rate = [NSString stringWithFormat:@"%d", self.ratingView.userRating];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/reviews", SERVICE_URL]];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	CosplayingAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[request addPostValue:delegate.context.activeImageKey forKey:@"image_key"];
	[request addPostValue:self.reviewerTextField.text forKey:@"reviewer"];
	[request addPostValue:rate forKey:@"rate"];
	[request addPostValue:self.characterNameTextField.text forKey:@"character_name"];
	[request addPostValue:self.keywordsTextField.text forKey:@"keywords"];
	[request addPostValue:self.commentTextView.text forKey:@"comment"];
	[request startSynchronous];
	NSError *error = [request error];
	if (!error) {
		NSString *response = [request responseString];
		[response showInDialog];
	} else {
		[error showInDialogWithTitle:@"Oops, Error"];
	}
	
}

- (IBAction)textValueChanged:(id) sender {
	BOOL allNotNullFieldsHaveValue = [self.reviewerTextField.text length] > 0 
										&& [self.characterNameTextField.text length] > 0 
										&& [self.keywordsTextField.text length] > 0;

	self.sendButton.enabled = allNotNullFieldsHaveValue;
}

@end
