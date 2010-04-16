//
//  Month2Matches.m
//  ATP Calendar
//
//  Created by James Wang on 4/16/10.
//  Copyright 2010 DerbySoft. All rights reserved.
//

#import "Month2Matches.h"


@implementation Month2Matches
@synthesize month;
@synthesize matches;

- (id)initWithMonth:(NSString *)theMonth matches:(NSArray *)theMatches {
	if (self = [super init]) {
		self.month = theMonth;
		self.matches = theMatches;
	}
	return self;
}

@end
