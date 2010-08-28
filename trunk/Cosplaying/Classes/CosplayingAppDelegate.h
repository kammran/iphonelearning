//
//  CosplayingAppDelegate.h
//  Cosplaying
//
//  Created by James Wang on 8/28/10.
//  Copyright DerbySoft 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImagesPreviewController;

@interface CosplayingAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	ImagesPreviewController *imagesPreviewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ImagesPreviewController *imagesPreviewController;

@end
