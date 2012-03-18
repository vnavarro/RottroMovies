//
//  FacebookViewController.h
//  SocialBOX
//
//  Created by Vitor Navarro on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimelineContentViewController.h"
#import "TopMenuViewController.h"
#import "FBSocialTabBarViewController.h"
#import "SVProgressHUD.h"


typedef enum FBAction{
  FBFeed,
  FBStatus,
  FBShowFeed,
  FBComment,
  FBShare,
  FBShareExternal
}FBAction;

@interface FacebookViewController : UIViewController <TimelineCellTouchDelegate,TopMenuDelegate,FBSocialBarDelegate,
UITextViewDelegate,FBRequestDelegate>{
  BOOL sendingStatus;
}
@property (retain, nonatomic) IBOutlet UIView *feed_view;
@property (retain, nonatomic) IBOutlet UIView *status_view;
@property (retain, nonatomic) IBOutlet UITextView *status_text;
@property (retain, nonatomic) IBOutlet UIButton *btn_send;
@property (retain, nonatomic) IBOutlet UIView *current_status_view;
@property (retain, nonatomic) IBOutlet UIImageView *avatar_view;
@property (retain, nonatomic) IBOutlet UIButton *btn_open_avatar;
@property (retain, nonatomic) IBOutlet UILabel *lbl_username;
@property (retain, nonatomic) IBOutlet UILabel *lbl_description;
@property (retain, nonatomic) IBOutlet UITextView *feed_text;
@property (nonatomic, assign) NSString *share_text;

@property (nonatomic) FBAction action;
@property (nonatomic,retain) TimelineContentViewController *fb_table;
@property (nonatomic,assign) UINavigationController *navigation_controller;
@property (nonatomic,retain) FBCustomPost *current_feed;

- (IBAction)sendStatus:(id)sender;
-(id)initWithAction:(FBAction)action;

@end
