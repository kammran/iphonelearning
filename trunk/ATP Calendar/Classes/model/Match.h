//
//  Match.h
//  ATP Calendar
//
//  Created by James Wang on 4/16/10.
//  Copyright 2010 DerbySoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Match : NSObject {
	NSString *name;
	NSString *date;
	NSString *city;
	NSString *website;
	NSString *introduction;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *website;
@property (nonatomic, retain) NSString *introduction;

- (id)initWithName:(NSString *)theName 
			  date:(NSString *)theDate 
			  city:(NSString *)theCity 
		   website:(NSString *)theWebsite 
	  introduction:(NSString *)theIntroduction;

@end
