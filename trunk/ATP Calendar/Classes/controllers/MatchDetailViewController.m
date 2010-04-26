//
//  MatchDetailViewController.m
//  ATP Calendar
//
//  Created by James Wang on 4/17/10.
//  Copyright 2010 DerbySoft. All rights reserved.
//

#import "MatchDetailViewController.h"
#import "Match.h"
#import "MatchWebViewController.h"
#import "MatchImageCoverFlowViewController.h"
#import "Context.h"
#import "ATP_CalendarAppDelegate.h"
#import "MatchImageFlowCoverViewDelegate.h"

@implementation MatchDetailViewController
@synthesize match;
@synthesize nameLabel;
@synthesize dateLabel;
@synthesize tournamentLabel;
@synthesize surfaceLabel;
@synthesize prizeMoneyLabel;
@synthesize drawLabel;
@synthesize websiteButton;
@synthesize ticketInfoLabel;
@synthesize singleWinnerLabel;
@synthesize doubleWinnersLabel;
@synthesize imageButton;

- (void)extractData {
	self.nameLabel.text = match.name;
	[self.imageButton setBackgroundImage:[match categoryImage] forState:UIControlStateNormal];
	[self.imageButton setBackgroundImage:[match categoryImage] forState:UIControlStateHighlighted];
	self.dateLabel.text = match.date;
	NSMutableString *tournament = [[NSMutableString alloc] init];
	[tournament appendString:match.city];
	if (match.country != nil && [match.country length] > 0) {
		[tournament appendFormat:@", %@", match.country];
	} 
	self.tournamentLabel.text = tournament;
	[tournament release];
	self.surfaceLabel.text = match.surface;
	NSMutableString *prizeMoney = [[NSMutableString alloc] init];
	if (match.prizeMoney != nil && [match.prizeMoney length] > 0) {
		[prizeMoney appendString:match.prizeMoney];
	}
	if (match.totalFinancialCommitment != nil && [match.totalFinancialCommitment length] >0) {
		[prizeMoney appendFormat:@" (%@)", match.totalFinancialCommitment];
	}
	self.prizeMoneyLabel.text = prizeMoney;
	[prizeMoney release];
	NSString *draw = [[NSString alloc] initWithFormat:@"SGL %d DBL %d", match.singleDraw, match.doubleDraw];
	self.drawLabel.text = draw;
	[draw release];
	[self.websiteButton setTitle:match.website forState:UIControlStateNormal];
	NSString *ticketInfo = nil;
	if (match.ticketEmail != nil && [match.ticketEmail length] > 0) {
		ticketInfo = [[NSString alloc] initWithFormat:@"%@ %@", match.ticketEmail, match.ticketPhone];
	} else {
		ticketInfo = [[NSString alloc] initWithFormat:@"%@", match.ticketPhone];
	}
	self.ticketInfoLabel.text = ticketInfo;
	[ticketInfo release];			  
	NSMutableString *winners = [[NSMutableString alloc] init];
	self.singleWinnerLabel.text = [NSString stringWithFormat:@"Singles : %@", match.singleWinner];
	self.doubleWinnersLabel.text = [NSString stringWithFormat:@"Doubles : %@", [match.doubleWinners componentsJoinedByString:@","]];
	[winners release];
}

- (IBAction)hyperlinkPressed:(id)sender {
	UIButton *button = (UIButton *)sender;
	NSString *currentTitle = button.currentTitle;
	if (currentTitle != nil) {
		MatchWebViewController *webViewController = [[MatchWebViewController alloc] initWithNibName:@"MatchWebView" bundle:nil];
		NSString *url = [[NSString alloc] initWithFormat:@"%@?redirect_by=iphone_atp_calendar", currentTitle];
		webViewController.title = @"Loading...";
		webViewController.url = url;
		[self.navigationController pushViewController:webViewController animated:YES];								
		[url release];
		[webViewController release];
	}
}

- (IBAction)showPictures:(id)sender {
	MatchImageCoverFlowViewController *coverFlowController = [[MatchImageCoverFlowViewController alloc] initWithNibName:@"MatchImageCoverFlowView" bundle:nil];
	MatchImageFlowCoverViewDelegate *matchImageFlowCoverViewDelegate = [Context delegate].matchImageFlowCoverViewDelegate;
	matchImageFlowCoverViewDelegate.matchName = self.match.name;
	FlowCoverView *flowCoverView = (FlowCoverView *) coverFlowController.view;
	flowCoverView.delegate = matchImageFlowCoverViewDelegate;
	NSString *title = [[NSString alloc] initWithFormat:@"Pictures Of %@", match.name];
	coverFlowController.title = title;
	[title release];
	//[[UIDevice currentDevice] setOrientation:UIInterfaceOrientationLandscapeRight];
	[self.navigationController pushViewController:coverFlowController animated:YES];
	[coverFlowController release];
}

- (void)viewDidLoad {
	[self extractData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)viewDidUnload {
	self.nameLabel = nil;
	self.imageButton = nil;
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
	[self.imageButton release];
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
