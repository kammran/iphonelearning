//
//  Month2Matches.h
//  ATP Calendar
//
//  Created by James Wang on 4/16/10.
//  Copyright 2010 DerbySoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Month2Matches : NSObject {
	NSString *month;
	NSArray *matches;
}

@property (nonatomic, retain) NSString *month;
@property (nonatomic, retain) NSArray *matches;

- (id)initWithMonth:(NSString *)theMonth matches:(NSArray *)theMatches;

@end
