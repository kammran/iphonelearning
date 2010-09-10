//
//  ImagesPreviewController.h
//  Cosplaying
//
//  Created by James Wang on 8/28/10.
//  Copyright 2010 Freeze!. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SERVICE_URL @"http://localhost:8080"
#define IMAGE_SERVER @"http://freezedisk.googlecode.com/svn/trunk/iphone/cosplaying/images/real"

@interface ImagesPreviewController : UIViewController <UISearchBarDelegate> {

	UISearchBar *searchBar;
	UIImageView *imageView1;
	UIImageView *imageView2;
	UIImageView *imageView3;
	UIImageView *imageView4;
	
}

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) IBOutlet UIImageView *imageView1;
@property (nonatomic, retain) IBOutlet UIImageView *imageView2;
@property (nonatomic, retain) IBOutlet UIImageView *imageView3;
@property (nonatomic, retain) IBOutlet UIImageView *imageView4;


- (IBAction)searchButtonPressed;
- (IBAction)segmentPressed:(id) sender;

@end
