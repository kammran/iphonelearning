//
//  ITuneReviewer.h
//  Cosplaying
//
//  Created by James Wang on 10/6/10.
//  Copyright 2010 Freeze!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ITuneReviewerDelegate;


@interface ITuneReviewer : NSObject <UIAlertViewDelegate> {
@private
    id <ITuneReviewerDelegate> _delegate;
	
}

@property(nonatomic,assign) id /*<ITuneReviewerDelegate>*/ delegate;    // weak reference

- (void)showReviewMessageIfRequired;

@end

@protocol ITuneReviewerDelegate <NSObject>

- (NSString *)appId;
- (NSString *)appType;
- (BOOL)shouldPresentReviewMessage;

@end
