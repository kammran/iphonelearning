//
//  ImageCache.m
//  Cosplaying
//
//  Created by James Wang on 9/22/10.
//  Copyright 2010 Freeze!. All rights reserved.
//

#import "NSDataCache.h"


@implementation NSDataCache

+ (NSString *)documentsDirectory {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

+ (NSString *)pathForFolder:(NSString *) folder name:(NSString *) name {
	//NSString *localDataPath = [[self documentsDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@", folder, name]];
	NSString *localDataPath = [[self documentsDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", name]];
	return localDataPath;
}

+ (BOOL)dataExistsInFolder:(NSString *) folder name:(NSString *) name {
	NSString *localDataPath = [self pathForFolder:folder name:name];
	return [[NSFileManager defaultManager] fileExistsAtPath:localDataPath];		
} 

+ (NSData *)loadDataInFolder:(NSString *) folder name:(NSString *) name {
	return [[NSData alloc] initWithContentsOfFile:[self pathForFolder:folder name:name]];
}

+ (void)saveData:(NSData *) data inFolder:(NSString *) folder name:(NSString *) name {
	[data writeToFile:[self pathForFolder:folder name:name] atomically:YES];
}



@end
