//
//  ResourceProvider.m
//  ATP Calendar
//
//  Created by Hello Baby on 4/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ResourceLoader.h"
#import "Month2Matches.h"
#import "Match.h"

@implementation ResourceLoader


+ (NSArray *)loadData {
	//TODO load data from plist or sqlite
	
	
	Match *Brisbane_International = [[Match alloc] initWithName:@"Brisbane International"];
	Brisbane_International.level = ATP250;
	Brisbane_International.date = @"03.01.2010";
	Brisbane_International.city = @"Brisbane";
	Brisbane_International.country = @"Austrilia";
	
	Match *Aircel_Chennai_Open = [[Match alloc] initWithName:@"Aircel Chennai Open"];
	Aircel_Chennai_Open.level = ATP250;
	
	Match *Qatar_ExxonMobil_Open = [[Match alloc] initWithName:@"Qatar ExxonMobil Open"];
	Qatar_ExxonMobil_Open.level = ATP250;
	
	Match *Medibank_International_Sydney = [[Match alloc] initWithName:@"Medibank International Sydney"];
	Medibank_International_Sydney.level = ATP250;
	
	Match *Heineken_Open = [[Match alloc] initWithName:@"Heineken Open"];
	Heineken_Open.level = ATP250;
	
	Match *Australian_Open = [[Match alloc] initWithName:@"Australian Open"];
	Australian_Open.level = GRAND_SLAM;
	
	NSArray *januaryMatches = [[NSArray alloc] initWithObjects:
							   Brisbane_International, 
							   Aircel_Chennai_Open, 
							   Qatar_ExxonMobil_Open, 
							   Medibank_International_Sydney, 
							   Heineken_Open, 
							   Australian_Open, 
							   nil];
	Month2Matches *january = [[Month2Matches alloc] initWithMonth:@"JANUARY" matches:januaryMatches];
	
	
	Match *maimi = [[Match alloc] initWithName:@"maimi"];
	Match *indiawer = [[Match alloc] initWithName:@"indiawer"];
	NSArray *februraryMatches = [[NSArray alloc] initWithObjects:maimi, indiawer, nil];
	Month2Matches *februrary = [[Month2Matches alloc] initWithMonth:@"FEBRUARY" matches:februraryMatches];
	return [[NSArray alloc] initWithObjects:january, februrary, nil];
}

@end
