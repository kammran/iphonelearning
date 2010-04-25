//
//  MatchWebViewController.m
//  ATP Calendar
//
//  Created by James Wang on 4/25/10.
//  Copyright 2010 DerbySoft. All rights reserved.
//

#import "MatchWebViewController.h"
#import "NSObject-Dialog.h";

@implementation MatchWebViewController
@synthesize url;
@synthesize webView;
@synthesize progressLabel;
@synthesize progressEnd;
@synthesize progressText;


- (void)viewDidLoad {
	self.webView.hidden = YES;
	self.progressLabel.text = @"Loading, Please Wait...";
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
	[webView loadRequest:request];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)viewDidUnload {
	self.url = nil;
	self.webView = nil;
	self.progressLabel = nil;
	self.progressText = nil;
	[super viewDidLoad];
}

- (void)dealloc {
	[self.url release];
	[self.webView release];
	[self.progressLabel release];
	[self.progressText release];
	[super dealloc];
}

#pragma mark -
#pragma mark UIWebViewDelegate Methods

- (void)webViewDidStartLoad:(UIWebView *)theWebView {
}

- (void)webViewDidFinishLoad:(UIWebView *)theWebView {
	progressLabel.hidden = YES;
	self.webView.hidden = NO;
}

- (void)webView:(UIWebView *)theWebView didFailLoadWithError:(NSError *)error {
	self.progressLabel.text = @"Couldn't open the website, please go back.";
	[error showInDialog];
	self.webView.hidden = YES;
}

@end
