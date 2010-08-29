//
//  ImagesPreviewController.h
//  Cosplaying
//
//  Created by James Wang on 8/28/10.
//  Copyright 2010 Freeze!. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImagesPreviewController : UIViewController <UISearchBarDelegate> {

	UISearchBar *searchBar;
	
}

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;

- (IBAction)searchButtonPressed;

@end
