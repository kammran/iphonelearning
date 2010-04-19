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
	UIImageView *categoryImageView;
	UILabel *dateLabel;
	UILabel *tournamentLabel;
	UILabel *surfaceLabel;
	UILabel *prizeMoneyLabel;
	UILabel *drawLabel;
	UILabel *ticketInfoLabel;
	UILabel *winnersLabel;
}
@property (nonatomic, retain) Match *match;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UIImageView *categoryImageView;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *tournamentLabel;
@property (nonatomic, retain) IBOutlet UILabel *surfaceLabel;
@property (nonatomic, retain) IBOutlet UILabel *prizeMoneyLabel;
@property (nonatomic, retain) IBOutlet UILabel *drawLabel;
@property (nonatomic, retain) IBOutlet UILabel *ticketInfoLabel;
@property (nonatomic, retain) IBOutlet UILabel *winnersLabel;
@end
