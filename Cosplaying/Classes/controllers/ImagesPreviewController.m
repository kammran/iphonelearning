//
//  ImagesPreviewController.m
//  Cosplaying
//
//  Created by James Wang on 8/28/10.
//  Copyright 2010 Freeze!. All rights reserved.
//

#import "ImagesPreviewController.h"
#import "SingleImageController.h"
#import "NSObject-Dialog.h"

@implementation ImagesPreviewController
@synthesize searchBar;


- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark -

#pragma mark Methods For Touch Events

- (BOOL)canResignFirstResponder {
	return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	for (UITouch *touch in touches) {
		UIView *touchedView = [touch view];
		NSLog(@"%@", [touchedView class]);
		if ([touchedView isKindOfClass:[UIImageView class]]) {
			UIImageView *imageView = (UIImageView *) touchedView;
			
			SingleImageController *singleImageController = [[SingleImageController alloc] initWithNibName:@"SingleImageController" bundle:nil];
			singleImageController.image = imageView.image;
			[self.navigationController pushViewController:singleImageController animated:YES];
			//[self.view insertSubview:singleImageController.view atIndex:100];
			[singleImageController release];
		}
	}	
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
}

#pragma mark -
#pragma mark IBAction Methods

- (IBAction)searchButtonPressed {
	self.searchBar.hidden = NO;
	[self.searchBar becomeFirstResponder];
}

#pragma mark -
#pragma mark UISearchBarDelegate Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	[[NSString stringWithFormat:@"You searched %@", theSearchBar.text] showInDialogWithTitle:@"Message"];
	[self.searchBar resignFirstResponder];
	self.searchBar.hidden = YES;	
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)theSearchBar {
	[self.searchBar resignFirstResponder];
	self.searchBar.hidden = YES;
}

@end
