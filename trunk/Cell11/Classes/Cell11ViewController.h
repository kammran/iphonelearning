//
//  Cell11ViewController.h
//  Cell11
//
//  Created by Hello Baby on 4/9/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kNameValueTag	1
#define kColorValueTag	2

@interface Cell11ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
	NSArray *computers;
}
@property (nonatomic, retain) NSArray *computers;
@end


