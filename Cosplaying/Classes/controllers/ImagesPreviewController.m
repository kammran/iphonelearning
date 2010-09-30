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
#import "Configuration.h"
#import "UIImageWithKey.h"
#import "CosplayingAppDelegate.h"
#import "Context.h"
#import "NSDataCache.h"
#import "ASIHTTPRequest.h"

@implementation ImagesPreviewController
@synthesize searchBar;
@synthesize segmentedControl;
@synthesize imageView1;
@synthesize imageView2;
@synthesize imageView3;
@synthesize imageView4;
@synthesize datePicker;
@synthesize previousButton;
@synthesize nextButton;
@synthesize q;
@synthesize keyword;
@synthesize offset;


#pragma mark -
#pragma mark Image Downloading Methods

- (void)downloadImage:(NSArray *)array {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	UIImageView *imageView = [array objectAtIndex:0];
	NSString *folder = [array objectAtIndex:1];
	NSString *name = [array objectAtIndex:2];
	NSString *key = [array objectAtIndex:3];
	NSString *url = [array objectAtIndex:4];
	
	NSData *imageData = nil;
	if ([NSDataCache dataExistsInFolder:folder name:name]) {
		imageData = [NSDataCache loadDataInFolder:folder name:name];
	} else {
		imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
		[NSDataCache saveData:imageData inFolder:folder name:name];
	}
	
	if (imageData) {
		UIImageWithKey *image = [[UIImageWithKey alloc] initWithData:imageData];
		image.key = key;
		imageView.image = image;
		[image release];
	} else {
		imageView.image = [UIImage imageNamed:@"missing.png"];
	}

	[pool release];
}

- (void)render:(NSArray *) array {
	int i = 1;
	for (NSDictionary *each in array) {
		NSString *folder = [each valueForKey:@"folder"];
		NSString *name = [each valueForKey:@"name"];
		NSString *key = [each valueForKey:@"key"];
		NSString *url = [NSString stringWithFormat:@"%@/%@/%@", IMAGE_SERVER, folder, name];
		if (i <= IMAGES_PER_PAGE) {
			UIImageView *imageView = [self valueForKey:[NSString stringWithFormat:@"imageView%d", i]];
			NSArray *array = [NSArray arrayWithObjects:imageView, folder, name, key, url, nil];
			[self performSelectorInBackground:@selector(downloadImage:) withObject:array];
		}
		i++;
	}
	
	nomore = (i < IMAGES_PER_PAGE);
	
	for (; i <= IMAGES_PER_PAGE; i++) {
		UIImageView *imageView = [self valueForKey:[NSString stringWithFormat:@"imageView%d", i]];
		imageView.image = [UIImage imageNamed:@"nomore.png"];
	}
	
}

- (void)resetImages2Downloading {
	for (int i = 1; i <= IMAGES_PER_PAGE; i++) {
		UIImageView *imageView = [self valueForKey:[NSString stringWithFormat:@"imageView%d", i]];
		imageView.image = [UIImage imageNamed:@"downloading.png"];
	}
}

- (void) request {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	[self resetImages2Downloading];

	NSString *url = [[NSString stringWithFormat:@"%@/images?q=%@&offset=%d&keyword=%@", SERVICE_URL, self.q, offset, self.keyword] 
					 stringByAddingPercentEscapesUsingEncoding:NSStringEncodingConversionExternalRepresentation];
	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
	request.useKeychainPersistence = YES;
	request.useSessionPersistence = YES;
	[request setUsername:GAE_USER];
	[request setPassword:GAE_PASS];
	[request startSynchronous];
	NSString *response = [request responseString];
	NSArray *array = [response JSONValue];
	[self render:array];
	
	[pool release];
}

- (void) requestInBackground {
	CosplayingAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	delegate.context.keyword = self.keyword;
	[self performSelectorInBackground:@selector(request) withObject:nil];
}

- (void) resetStateWith:(NSString *) theQ {
	self.offset = 0;
	self.q = theQ;
	self.keyword = @"";
}

- (void) requestRecents {
	[self resetStateWith:@"recent"];
	[self requestInBackground];
}

- (void) requestTopRated {
	[self resetStateWith:@"toprated"];
	[self requestInBackground];
}

- (void) requestPopular {
	[self resetStateWith:@"popular"];
	[self requestInBackground];
}

- (void) requestSelectedFolder {
	[self resetStateWith:@"folder"];
	NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	self.keyword = [formatter stringFromDate:self.datePicker.date];
	[formatter release];
	[self requestInBackground];
}

- (void) requestSearch {
	[self resetStateWith:@"search"];
	self.keyword = self.searchBar.text;
	[self requestInBackground];
}

#pragma mark -
#pragma mark View Controller LifeCycle Methods

- (void) setStyle {
	//self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	self.segmentedControl.tintColor = [UIColor darkGrayColor];
	[self.previousButton setImage:[UIImage imageNamed:@"previous-highlight.png"] forState:UIControlStateHighlighted];
	[self.nextButton setImage:[UIImage imageNamed:@"next-highlight.png"] forState:UIControlStateHighlighted];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.datePicker = [[UIDatePicker alloc] init];
	[self setStyle];
	[self requestRecents];
}

- (void)viewDidUnload {
	self.imageView1 = nil;
    self.imageView2 = nil;
	self.imageView3 = nil;
	self.imageView4 = nil;
	self.searchBar = nil;
	self.segmentedControl = nil;
	self.q = nil;
	self.keyword = nil;
	self.datePicker = nil;
	self.previousButton = nil;
	self.nextButton = nil;
	[super viewDidUnload];
}


- (void)dealloc {
	[self.imageView1 release];
	[self.imageView2 release];
	[self.imageView3 release];
	[self.imageView4 release];
	[self.searchBar release];
	[self.segmentedControl release];
	[self.q release];
	[self.keyword release];
	[self.datePicker release];
	[self.previousButton release];
	[self.nextButton release];
    [super dealloc];
}

#pragma mark -

#pragma mark Methods For Touch Events

- (BOOL)canResignFirstResponder {
	return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
		
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	//for (UITouch *touch in touches) {
		UIView *touchedView = [touch view];
		NSLog(@"%@", [touchedView class]);
		if ([touchedView isKindOfClass:[UIImageView class]]) {
			UIImageView *imageView = (UIImageView *) touchedView;
			
			SingleImageController *singleImageController = [[SingleImageController alloc] initWithNibName:@"SingleImageController" bundle:nil];
			
			UIImage *selectedImage = (UIImage *) imageView.image;
			SEL keyAccessor = @selector(key);
			if (![selectedImage respondsToSelector:keyAccessor]) {
				return;
			}
			
			CosplayingAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
			delegate.context.activeImageKey = [selectedImage performSelector:keyAccessor];
			
			singleImageController.image = selectedImage;
			
			AnimationDefinition *animationDefinition = [[AnimationDefinition alloc] 
														initWithTransition:UIViewAnimationTransitionCurlDown
														curve:UIViewAnimationCurveEaseInOut
														duration:1];
			[self.navigationController pushViewController:singleImageController withAnimation:animationDefinition];
			[singleImageController release];
			[animationDefinition release];
		}
	//}
}

#pragma mark -
#pragma mark IBAction Methods

- (void)hiddeSearch {
	[self.searchBar resignFirstResponder];
	self.searchBar.hidden = YES;
}


- (IBAction)searchButtonPressed {
	self.searchBar.hidden = NO;
	[self.searchBar becomeFirstResponder];
}

- (IBAction)segmentPressed {
	[self hiddeSearch];
	
	if (self.segmentedControl.selectedSegmentIndex == 0) {
		[self requestRecents];
	} else if (self.segmentedControl.selectedSegmentIndex == 1) {
		[self requestTopRated];
	} else if (self.segmentedControl.selectedSegmentIndex == 2) {
		[self requestPopular];
	}
}

- (IBAction)showDatePicker {
	[self hiddeSearch];
	
	//TODO find a better way for UIActionSheet 
	UIActionSheet *actionSheet = [[UIActionSheet alloc] 
								  initWithTitle:@"\r\r\r\r\r\r\r\r\r\r\r\r"
								  delegate:self
								  cancelButtonTitle:@"Cancel"
								  destructiveButtonTitle:@"Go to selected date" 
								  otherButtonTitles:nil,
								  nil];
	
	self.datePicker.datePickerMode = UIDatePickerModeDate;
	[actionSheet showInView:self.view];
	[actionSheet addSubview:self.datePicker];
	[actionSheet setBounds:CGRectMake(0, 0, 320, 400)];
    CGRect pickerRect = self.datePicker.bounds;
    self.datePicker.bounds = pickerRect;
	
	[actionSheet release];
}

- (IBAction)previousPressed {
	self.offset -= IMAGES_PER_PAGE;
	if (self.offset < 0) {
		self.offset = 0;
		return;
	}
	[self requestInBackground];
}

- (IBAction)nextPressed {
	if (nomore) {
		return;
	}
	
	self.offset += IMAGES_PER_PAGE;
	[self requestInBackground];
}

#pragma mark -
#pragma mark UISearchBarDelegate Methods


- (void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	[self.searchBar resignFirstResponder];
	self.searchBar.hidden = YES;	
	[self.segmentedControl setSelectedSegmentIndex:-1];
	[self requestSearch];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)theSearchBar {
	[self hiddeSearch];
}

#pragma mark -
#pragma mark UIActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex != [actionSheet cancelButtonIndex])  {
		[self requestSelectedFolder];
	}
}


@end
