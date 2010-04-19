//
//  Match.m
//  ATP Calendar
//
//  Created by James Wang on 4/16/10.
//  Copyright 2010 DerbySoft. All rights reserved.
//

#import "Match.h"


@implementation Match

@synthesize category;
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


- (UIImage *)categoryImage {
	NSString *imageName = [[NSString alloc] initWithFormat:@"%@.png", self.category];
	UIImage *categoryImage = [UIImage imageNamed:imageName];
	[imageName release];
	return categoryImage;
}

@end
