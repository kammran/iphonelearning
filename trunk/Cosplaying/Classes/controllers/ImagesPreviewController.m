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
#import "UINavigationController-Animation.h"
#import "AnimationDefinition.h"
#import "JSON.h"

@implementation ImagesPreviewController
@synthesize searchBar;
@synthesize imageView1;
@synthesize imageView2;
@synthesize imageView3;
@synthesize imageView4;


- (void)render:(NSArray *) array {
	int i = 1;
	for (NSDictionary *each in array) {
		NSString *folder = [each valueForKey:@"folder"];
		NSString *name = [each valueForKey:@"name"];
		NSString *url = [NSString stringWithFormat:@"%@/%@/%@", IMAGE_SERVER, folder, name];
		NSLog(@"%@", url);
		
		if (i <= 4) {
			UIImageView *imageView = [self valueForKey:[NSString stringWithFormat:@"imageView%d", i]];
			imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
		}
		
		i++;
	}
}

#pragma mark -
#pragma mark Remoting Methods
- (void) requestRecents {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSString *q = @"recent";
	int offset = 0;
	NSString *url = [[NSString stringWithFormat:@"%@/images?q=%@&offset=%d", SERVICE_URL, q, offset] 
					 stringByAddingPercentEscapesUsingEncoding:NSStringEncodingConversionExternalRepresentation];
	
	
	NSString *response = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
	NSArray *array = [response JSONValue];
	
	[self render:array];
	
	[response release];

	[pool release];
}



- (void)viewDidLoad {
	[super viewDidLoad];
	[self performSelectorInBackground:@selector(requestRecents) withObject:nil];
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
			
			AnimationDefinition *animationDefinition = [[AnimationDefinition alloc] 
														initWithTransition:UIViewAnimationTransitionCurlDown
														curve:UIViewAnimationCurveEaseInOut
														duration:1];
			[self.navigationController pushViewController:singleImageController withAnimation:animationDefinition];
			[singleImageController release];
			[animationDefinition release];
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

- (IBAction)segmentPressed:(id) sender {
	UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
	[[NSString stringWithFormat:@"%d", segmentedControl.selectedSegmentIndex] showInDialog];
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
