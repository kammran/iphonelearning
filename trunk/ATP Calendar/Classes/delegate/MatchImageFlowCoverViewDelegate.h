//
//  MatchImageFlowCoverViewDelegate.h
//  ATP Calendar
//
//  Created by James Wang on 4/27/10.
//  Copyright 2010 DerbySoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlowCoverView.h"

@interface MatchImageFlowCoverViewDelegate : NSObject <FlowCoverViewDelegate> {
	NSString *matchName;
}
@property (nonatomic, retain) NSString *matchName;
@end
