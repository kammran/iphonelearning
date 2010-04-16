//
//  RootViewController.h
//  ATP Calendar
//
//  Created by James Wang on 4/16/10.
//  Copyright DerbySoft 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MatchListViewController;

@interface RootViewController : UITableViewController {
	MatchListViewController *matchListViewController;
}
@property (nonatomic, retain) MatchListViewController *matchListViewController;
@end
