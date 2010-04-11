//
//  SectionsViewController.h
//  Sections
//
//  Created by James Wang on 4/11/10.
//  Copyright DerbySoft 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	NSDictionary *names;
	NSArray *keys;
}

@property (nonatomic, retain) NSDictionary *names;
@property (nonatomic, retain) NSArray *keys;

@end

