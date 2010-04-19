//
//  MatchDetailViewController.m
//  ATP Calendar
//
//  Created by James Wang on 4/17/10.
//  Copyright 2010 DerbySoft. All rights reserved.
//

#import "MatchDetailViewController.h"
#import "Match.h"

@implementation MatchDetailViewController
@synthesize match;
@synthesize nameLabel;
@synthesize categoryImageView;
@synthesize dateLabel;
@synthesize tournamentLabel;
@synthesize surfaceLabel;
@synthesize prizeMoneyLabel;
@synthesize drawLabel;
@synthesize websiteButton;
@synthesize ticketInfoLabel;
@synthesize singleWinnerLabel;
@synthesize doubleWinnersLabel;


- (void)extractData {
	self.nameLabel.text = match.name;
	self.categoryImageView.image = [match categoryImage];
	self.dateLabel.text = match.date;
	NSString *tournament = [[NSString alloc] initWithFormat:@"%@, %@", match.city, match.country];
	self.tournamentLabel.text = tournament;
	[tournament release];
	self.surfaceLabel.text = match.surface;
	NSString *prizeMoney = [[NSString alloc] initWithFormat:@"%@ (%@)", match.prizeMoney, match.totalFinancialCommitment];
	self.prizeMoneyLabel.text = prizeMoney;
	[prizeMoney release];
	NSString *draw = [[NSString alloc] initWithFormat:@"SGL %d DBL %d", match.singleDraw, match.doubleDraw];
	self.drawLabel.text = draw;
	[draw release];
	[self.websiteButton setTitle:match.website forState:UIControlStateNormal];
	NSString *ticketInfo = nil;
	if (match.ticketEmail != nil) {
		ticketInfo = [[NSString alloc] initWithFormat:@"%@ %@", match.ticketEmail, match.ticketPhone];
	} else {
		ticketInfo = [[NSString alloc] initWithFormat:@"%@", match.ticketPhone];
	}
	self.ticketInfoLabel.text = ticketInfo;
	[ticketInfo release];			  
	NSMutableString *winners = [[NSMutableString alloc] init];
	self.singleWinnerLabel.text = [NSString stringWithFormat:@"Singles : %@", match.singleWinner];
	self.doubleWinnersLabel.text = [NSString stringWithFormat:@"Doubles : %@", [match.doubleWinners componentsJoinedByString:@", "]];
	[winners release];
}

- (IBAction)hyperlinkPressed:(id)sender {
	UIButton *button = (UIButton *)sender;
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:button.currentTitle]];
}

- (void)viewDidLoad {
	[self extractData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)viewDidUnload {
	self.nameLabel = nil;
	self.categoryImageView = nil;
	self.dateLabel = nil;
	self.tournamentLabel = nil;
	self.surfaceLabel = nil;
	self.prizeMoneyLabel = nil;
	self.drawLabel = nil;
	self.ticketInfoLabel = nil;
	self.singleWinnerLabel = nil;
	self.doubleWinnersLabel = nil;
	[super viewDidUnload];
}

- (void)dealloc {
	[self.nameLabel release];
	[self.categoryImageView release];
	[self.dateLabel release];
	[self.tournamentLabel release];
	[self.surfaceLabel release];
	[self.prizeMoneyLabel release];
	[self.drawLabel release];
	[self.ticketInfoLabel release];
	[self.singleWinnerLabel release];
	[self.doubleWinnersLabel release];
	[super dealloc];
}

@end
