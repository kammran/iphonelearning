//
//  MatchImageCoverFlowViewController.h
//  ATP Calendar
//
//  Created by Hello Baby on 4/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Match;

@interface MatchImageCoverFlowViewController : UIViewController {
	UIImageView *imageView;
	Match *match;
}
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) Match *match;
@end
