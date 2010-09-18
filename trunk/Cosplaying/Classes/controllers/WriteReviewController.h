//
//  WriteReviewController.h
//  Cosplaying
//
//  Created by Hello Baby on 9/16/10.
//  Copyright 2010 Freeze!. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WriteReviewController : UIViewController {

	UISegmentedControl *rateSegment;
	UITextField *reviewerTextField;
	UITextField *characterNameTextField;
	UITextField *keywordsTextField;
	UITextView *commentTextView;
	
}

@property (nonatomic, retain) IBOutlet UISegmentedControl *rateSegment;
@property (nonatomic, retain) IBOutlet UITextField *reviewerTextField;
@property (nonatomic, retain) IBOutlet UITextField *characterNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *keywordsTextField;
@property (nonatomic, retain) IBOutlet UITextView *commentTextView;


- (IBAction)back;
- (IBAction)sendReview;

@end
