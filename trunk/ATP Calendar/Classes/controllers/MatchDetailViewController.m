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

- (void)extractData {
	self.nameLabel.text = self.match.name;
}

- (void)viewDidLoad {
	[self extractData];
}

@end
