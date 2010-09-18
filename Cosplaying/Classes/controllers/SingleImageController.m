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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (void)dealloc {
	[self.imageView release];
	[self.image release];
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

-(IBAction)viewInformation:(id)sender {
	ImageInformationController *imageInformationController = [[ImageInformationController alloc] initWithNibName:@"ImageInformationController" bundle:nil];
	[self.navigationController pushViewController:imageInformationController animated:YES];
	[imageInformationController release];
}


@end
