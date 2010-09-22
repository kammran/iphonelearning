//
//  SingleImageController.m
//  Cosplaying
//
//  Created by James Wang on 8/29/10.
//  Copyright 2010 Freeze!. All rights reserved.
//

#import "SingleImageController.h"
#import "NSObject-Dialog.h"
#import "AnimationDefinition.h"
#import "UINavigationController-Animation.h"
#import "ImageInformationController.h"

@implementation SingleImageController
@synthesize imageView;
@synthesize image;
@synthesize progressView;
@synthesize progressLabel;


#pragma mark -
#pragma mark UIViewController Delegate Methods

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.imageView.image = self.image;
	[super viewDidLoad];
}

- (void)viewDidUnload {
	self.imageView = nil;
	self.image = nil;
	self.progressView = nil;
	self.progressLabel = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (void)dealloc {
	[self.imageView release];
	[self.image release];
	[self.progressView release];
	[self.progressLabel release];
    [super dealloc];
}

#pragma mark -
#pragma mark IBAction Methods

- (IBAction)backToSuperView:(id) sender {	
	AnimationDefinition *animationDefinition = [[AnimationDefinition alloc] 
												initWithTransition:UIViewAnimationTransitionCurlUp
												curve:UIViewAnimationCurveEaseInOut
												duration:1];
	[self.navigationController popViewControllerWithAnimation:animationDefinition];
	[animationDefinition release];
}

- (IBAction)viewInformation:(id)sender {
	ImageInformationController *imageInformationController = [[ImageInformationController alloc] initWithNibName:@"ImageInformationController" bundle:nil];
	[self.navigationController pushViewController:imageInformationController animated:YES];
	[imageInformationController release];
}

- (void)image:(UIImage *)theImage didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
	self.imageView.alpha = 1.0f;
	self.progressView.hidden = YES;
	self.progressLabel.hidden = YES;
    if (error != NULL) {
		[[NSString stringWithFormat:@"Failed to save image due to: \n %@", error] showInDialogWithTitle:@"Oops! Error"];
	} else {
		[@"To see the saved image, simply open app \"Photos\", thanks:)" showInDialogWithTitle:@"Success"];
	}
}

- (void)increaseProgress {
	progress += 10.0f;
	self.progressView.progress = progress / 100.0f;
}

- (IBAction) saveImage {
	self.imageView.alpha = 0.6f;
	self.progressView.progress = 0.0f;
	self.progressView.hidden = NO;
	self.progressLabel.hidden = NO;
	[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(increaseProgress) userInfo:nil repeats:YES];
	UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

@end
