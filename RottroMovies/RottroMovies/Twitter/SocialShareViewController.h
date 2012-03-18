//
//  TwitterViewController.h
//  SocialBOX
//
//  Created by Vitor Navarro on 8/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterAccessor.h"
#import "FacebookAccessor.h"
#import "SVProgressHUD.h"

@interface SocialShareViewController : UIViewController  <UITextViewDelegate,UITextFieldDelegate,FBRequestDelegate>{

}

@property (retain, nonatomic) IBOutlet UILabel *lblShareSize;
@property (retain, nonatomic) IBOutlet UITextView *txtStatus;
@property (nonatomic,retain) NSString *status;
@property (nonatomic,assign) BOOL isTwitter;

- (void)updateStatus;

-(id)initWithStatus:(NSString *)status;
@end
