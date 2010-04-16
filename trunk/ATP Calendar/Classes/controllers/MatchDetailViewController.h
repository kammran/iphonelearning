//
//  MatchDetailViewController.h
//  ATP Calendar
//
//  Created by James Wang on 4/17/10.
//  Copyright 2010 DerbySoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Match;

@interface MatchDetailViewController : UIViewController {
	Match *match;
	UILabel *nameLabel;
}
@property (nonatomic, retain) Match *match;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@end
