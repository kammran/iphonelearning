//
//  MatchImageCoverFlowViewController.h
//  ATP Calendar
//
//  Created by Hello Baby on 4/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowCoverView.h"
@class Match;


@interface MatchImageCoverFlowViewController : UIViewController <FlowCoverViewDelegate> {
	Match *match;
}
@property (nonatomic, retain) Match *match;
@end
