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
	NSMutableArray *array = [[NSMutableArray alloc] init];
	
	NSData *data = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"xml"]];
	GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
	GDataXMLElement * root = [doc rootElement];
	NSArray *monthes = [root elementsForName:@"month"];
	
	for (id month in monthes) {
		GDataXMLElement *monthElement = (GDataXMLElement *) month;
		NSString *monthName = [monthElement stringValueForName:@"name"];
		Month2Matches *month2Matches = [[Month2Matches alloc] initWithName:monthName];
		[array addObject:month2Matches];
		for (id eachMatchElement in [monthElement elementsForName:@"match"]) {
			GDataXMLElement *matchElement = (GDataXMLElement *) eachMatchElement;
			Match *match = [[Match alloc] initWithName:[matchElement stringValueForName:@"name"]];
			match.category = [matchElement stringValueForName:@"category"];
			match.city = [matchElement stringValueForName:@"city"];
			match.country = [matchElement stringValueForName:@"country"];
			match.date = [matchElement stringValueForName:@"date"];
			match.doubleDraw = [[matchElement stringValueForName:@"dbl"] intValue];
			NSString *doubleWinners = [matchElement stringValueForName:@"double_winners"];
			NSLog(@"%@", doubleWinners);
			match.doubleWinners = [doubleWinners componentsSeparatedByString:@","];
			match.prizeMoney = [matchElement stringValueForName:@"prize"];
			match.singleDraw = [[matchElement stringValueForName:@"sgl"] intValue];
			match.singleWinner = [matchElement stringValueForName:@"single_winner"];
			match.surface = [matchElement stringValueForName:@"surface"];
			match.ticketEmail = [matchElement stringValueForName:@"email"];
			match.ticketPhone = [matchElement stringValueForName:@"tel"];
			match.totalFinancialCommitment = [matchElement stringValueForName:@"total"];
			[month2Matches addMatch:match];
		}
	}
	
	[data release];
	[doc release];
	return array;
}



@end
