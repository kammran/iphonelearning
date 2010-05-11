//
//  ResourceProvider.h
//  ATP Calendar
//
//  Created by Hello Baby on 4/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode-Extension.h"

#define SERVICE_URL	@"http://freezedisk.googlecode.com/svn/trunk/iphone/ATP-Calendar/"

@interface ResourceLoader : NSObject {

}

+ (NSArray *)loadData;

@end
