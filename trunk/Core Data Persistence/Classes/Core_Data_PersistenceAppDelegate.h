//
//  Core_Data_PersistenceAppDelegate.h
//  Core Data Persistence
//
//  Created by Hello Baby on 6/17/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class PersistenceViewController;

@interface Core_Data_PersistenceAppDelegate : NSObject <UIApplicationDelegate> {

    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;

    UIWindow *window;
	PersistenceViewController *rootController;
}

- (NSString *)applicationDocumentsDirectory;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PersistenceViewController *rootController;

@end

