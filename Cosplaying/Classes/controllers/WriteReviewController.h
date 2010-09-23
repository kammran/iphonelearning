//
//  WriteReviewController.h
//  Cosplaying
//
//  Created by Hello Baby on 9/16/10.
//  Copyright 2010 Freeze!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCRatingView.h"

@interface WriteReviewController : UIViewController {

	SCRatingView *ratingView;
	UITextField *reviewerTextField;
	UITextField *characterNameTextField;
	UITextField *keywordsTextField;
	UITextView *commentTextView;
	UIBarItem *sendButton;
	
}

@property (nonatomic, retain) IBOutlet SCRatingView *ratingView;
@property (nonatomic, retain) IBOutlet UITextField *reviewerTextField;
@property (nonatomic, retain) IBOutlet UITextField *characterNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *keywordsTextField;
@property (nonatomic, retain) IBOutlet UITextView *commentTextView;
@property (nonatomic, retain) IBOutlet UIBarItem *sendButton;


- (IBAction)back;
- (IBAction)sendReview;
- (IBAction)textValueChanged:(id) sender;

@end
