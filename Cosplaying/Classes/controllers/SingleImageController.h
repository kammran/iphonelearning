//
//  SingleImageController.h
//  Cosplaying
//
//  Created by James Wang on 8/29/10.
//  Copyright 2010 Freeze!. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleImageController : UIViewController {
	UIImageView *imageView;
	UIImage *image;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) UIImage *image;


- (IBAction)backToSuperView:(id) sender;
- (IBAction)viewInformation:(id) sender;

@end
