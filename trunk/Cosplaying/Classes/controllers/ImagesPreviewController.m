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
@synthesize datePicker;
@synthesize jumpToDateButton;

- (void)downloadImage:(NSArray *)array {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	UIImageView *imageView = [array objectAtIndex:0];
	NSString *url = [array objectAtIndex:1];
	imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
	[pool release];
}

- (void)render:(NSArray *) array {
	if ([array count] ==0) {
		[@"Sorry, no images for your selection." showInDialog];
	}
	
	int i = 1;
	for (NSDictionary *each in array) {
		NSString *folder = [each valueForKey:@"folder"];
		NSString *name = [each valueForKey:@"name"];
		NSString *url = [NSString stringWithFormat:@"%@/%@/%@", IMAGE_SERVER, folder, name];
		if (i <= IMAGES_PER_PAGE) {
			UIImageView *imageView = [self valueForKey:[NSString stringWithFormat:@"imageView%d", i]];
			NSArray *array = [NSArray arrayWithObjects:imageView, url, nil];
			[self performSelectorInBackground:@selector(downloadImage:) withObject:array];
		}
		
		i++;
	}
}


#pragma mark -
#pragma mark Remoting Methods

- (void) request {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	NSString *url = [[NSString stringWithFormat:@"%@/images?q=%@&offset=%d&keyword=%@", SERVICE_URL, q, offset, keyword] 
					 stringByAddingPercentEscapesUsingEncoding:NSStringEncodingConversionExternalRepresentation];
	
	
	NSString *response = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
	NSArray *array = [response JSONValue];
	[self render:array];
	[response release];
	
	[pool release];
}

- (void) requestInBackground {
	[self performSelectorInBackground:@selector(request) withObject:nil];
}

- (void) requestRecents {
	q = @"recent";
	[self requestInBackground];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self requestRecents];
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
	if (segmentedControl.selectedSegmentIndex == 2) {
		//jump to date
		self.datePicker.hidden = NO;
		self.jumpToDateButton.hidden = NO;
	} else {
		self.datePicker.hidden = YES;
		self.jumpToDateButton.hidden = YES;		
	}
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

#pragma mark -
#pragma mark UI Buttons Methods

- (void)resetImages2Downloading {
	for (int i = 1; i <= IMAGES_PER_PAGE; i++) {
		UIImageView *imageView = [self valueForKey:[NSString stringWithFormat:@"imageView%d", i]];
		imageView.image = [UIImage imageNamed:@"downloading.png"];
	}
}

- (IBAction)previousPressed {
	offset -= IMAGES_PER_PAGE;
	if (offset < 0) {
		offset = 0;
		return;
	}
	[self resetImages2Downloading];
	[self requestInBackground];
}

- (IBAction)nextPressed {
	offset += IMAGES_PER_PAGE;
	[self resetImages2Downloading];
	[self requestInBackground];
}

- (IBAction)jumpToDatePressed {
	self.datePicker.hidden = YES;
	self.jumpToDateButton.hidden = YES;
	
	NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	keyword = [formatter stringFromDate:self.datePicker.date];
	[formatter release];
	
	q = @"folder";
	offset = 0;
	[self requestInBackground];
}

@end
