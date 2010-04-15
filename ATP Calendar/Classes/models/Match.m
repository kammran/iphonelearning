//
//  Match.m
//  ATP Calendar
//
//  Created by James Wang on 4/16/10.
//  Copyright 2010 DerbySoft. All rights reserved.
//

#import "Match.h"


@implementation Match
@synthesize name;
@synthesize date;
@synthesize city;
@synthesize website;
@synthesize introduction;


- (id)initWithName:(NSString *)theName 
			  date:(NSString *)theDate 
			  city:(NSString *)theCity 
		   website:(NSString *)theWebsite 
	  introduction:(NSString *)theIntroduction {

	if (self = [super init]) {
		self.name = theName;
		self.date = theDate;
		self.city = theCity;
		self.website = theWebsite;
		self.introduction = theIntroduction;
	}
	return self;
}


@end
