//
//  TwitterAuthViewController.h
//  SocialBOX
//
//  Created by Vitor Navarro on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterAccessor.h"


@interface TwitterAuthViewController : UIViewController <UIWebViewDelegate> {
  IBOutlet UIWebView *webview_auth;
}

@property (nonatomic, retain) NSURL *request_url;

-(void)showErrorAlert;

@end
