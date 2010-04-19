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
@synthesize ticketInfoLabel;
@synthesize winnersLabel;


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
	NSString *ticketInfo = nil;
	if (match.ticketEmail != nil) {
		ticketInfo = [[NSString alloc] initWithFormat:@"%@ %@", match.ticketEmail, match.ticketPhone];
	} else {
		ticketInfo = [[NSString alloc] initWithFormat:@"%@", match.ticketPhone];
	}
	self.ticketInfoLabel.text = ticketInfo;
	[ticketInfo release];			  
	NSMutableString *winners = [[NSMutableString alloc] init];
	if (match.singleWinner != nil) {
		[winners appendString:@"Single Winner : "];
		[winners appendString:match.singleWinner];
		[winners appendString:@"\n"];
		[winners appendString:[match.doubleWinners componentsJoinedByString:@", "]];
	}
	self.winnersLabel.text = winners;
	[winners release];
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
	self.winnersLabel = nil;
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
	[self.winnersLabel release];
	[super dealloc];
}

@end
