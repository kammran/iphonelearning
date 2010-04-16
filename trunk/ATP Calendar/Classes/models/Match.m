//
//  Match.m
//  ATP Calendar
//
//  Created by James Wang on 4/16/10.
//  Copyright 2010 DerbySoft. All rights reserved.
//

#import "Match.h"


@implementation Match

@synthesize level;
@synthesize name;
@synthesize date;
@synthesize city;
@synthesize country;
@synthesize surface;
@synthesize prizeMoney;
@synthesize totalFinancialCommitment;
@synthesize singleDraw;
@synthesize doubleDraw;
@synthesize ticketPhone;
@synthesize ticketEmail;
@synthesize singleWinner;
@synthesize doubleWinners;
@synthesize website;
@synthesize introduction;


- (id)initWithName:(NSString *)theName {

	if (self = [super init]) {
		self.name = theName;
	}
	return self;
}


@end
