//
//  MatchWebViewController.h
//  ATP Calendar
//
//  Created by James Wang on 4/25/10.
//  Copyright 2010 DerbySoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MatchWebViewController : UIViewController <UIWebViewDelegate> {
	NSString *url;
	UIWebView *webView;
	UILabel *progressLabel;
	Boolean progressEnd;
	NSMutableString *progressText;
}
@property (nonatomic) Boolean progressEnd;
@property (nonatomic, retain) NSMutableString *progressText;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UILabel *progressLabel;
@end
