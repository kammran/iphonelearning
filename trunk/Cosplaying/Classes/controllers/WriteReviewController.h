//
//  WriteReviewController.h
//  Cosplaying
//
//  Created by Hello Baby on 9/16/10.
//  Copyright 2010 Freeze!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCRatingView.h"
#import "TextViewWithPlaceholder.h";

#define SETTINGS_FOLDER @"settings"
#define SETTING_FILE_NAME @"info.plist"
#define REVIEWER_KEY @"reviewer"

@interface WriteReviewController : UIViewController <SCRatingDelegate> {

	SCRatingView *ratingView;
	UILabel *ratingLabel;
	UITextField *reviewerTextField;
	UITextField *characterNameTextField;
	UITextField *keywordsTextField;
	TextViewWithPlaceholder *commentTextView;
	UIBarItem *sendButton;
	
}

@property (nonatomic, retain) IBOutlet SCRatingView *ratingView;
@property (nonatomic, retain) IBOutlet UILabel *ratingLabel;
@property (nonatomic, retain) IBOutlet UITextField *reviewerTextField;
@property (nonatomic, retain) IBOutlet UITextField *characterNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *keywordsTextField;
@property (nonatomic, retain) IBOutlet TextViewWithPlaceholder *commentTextView;
@property (nonatomic, retain) IBOutlet UIBarItem *sendButton;


- (IBAction)back;
- (IBAction)sendReview;
- (IBAction)textValueChanged:(id) sender;

@end
