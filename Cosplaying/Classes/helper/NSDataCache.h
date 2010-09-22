//
//  ImageCache.h
//  Cosplaying
//
//  Created by James Wang on 9/22/10.
//  Copyright 2010 Freeze!. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDataCache : NSObject {

}

+ (BOOL)dataExistsInFolder:(NSString *) folder name:(NSString *) name; 
+ (NSData *)loadDataInFolder:(NSString *) folder name:(NSString *) name;
+ (void)saveData:(NSData *) data inFolder:(NSString *) folder name:(NSString *) name;

@end
