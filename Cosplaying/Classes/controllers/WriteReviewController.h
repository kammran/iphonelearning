//
//  WriteReviewController.h
//  Cosplaying
//
//  Created by Hello Baby on 9/16/10.
//  Copyright 2010 Freeze!. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WriteReviewController : UIViewController {

	UITextField *characterNameTextField;
	UITextField *keyworldsTextField;
	UITextView *reviewTextView;
	
}

@property (nonatomic, retain) IBOutlet UITextField *characterNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *keyworldsTextField;
@property (nonatomic, retain) IBOutlet UITextView *reviewTextView;


- (IBAction)back;
- (IBAction)sendReview;

@end
