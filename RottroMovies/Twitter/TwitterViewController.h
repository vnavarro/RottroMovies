//
//  TwitterViewController.h
//  SocialBOX
//
//  Created by Vitor Navarro on 8/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweets.h"
#import "TimelineContentViewController.h"
#import "TwitterAccessor.h"
#import "TopMenuViewController.h"
#import "TTSocialTabBarViewConroller.h"

typedef enum TTAction{
  TableTweets,
  TableRts,
  TableMentions,
  TableDMs,
  TableBooks,
  CurrentTweet,
  NewTweet,
  Retweet,
  Mention,
  DirectMessage,
  TTShareExternal
}TTAction;

@interface TwitterViewController : UIViewController  <TopMenuDelegate,TimelineCellTouchDelegate,
TTSocialBarDelegate,UIAlertViewDelegate,UITextViewDelegate,UITextFieldDelegate>{
  UIImageView *imgview_avatar;
  UIButton *btn_retweet;
  UIButton *btn_mention;
  UIButton *btn_direct_message;
  UIButton *btn_bookmark;
  UIButton *btn_search;
  UIButton *directMessageTouched;
  UIButton *searchTouched;
  UITextView *text_view;
  UILabel *lbl_username;
  UIView *current_tweet_view;
  UIView *tweet_view;
  UILabel *lbl_description;
  UIView *tweets_view;
  UILabel *lbl_data;
  UIButton *btn_open_profile;
  UITextView *text_view_tweet_creation;
  UIButton *btn_tweet_action;
}
//IBOutlets
@property (nonatomic, retain) IBOutlet UIButton *btn_retweet;
@property (nonatomic, retain) IBOutlet UIButton *btn_mention;
@property (nonatomic, retain) IBOutlet UIButton *btn_direct_message;
@property (nonatomic, retain) IBOutlet UIButton *btn_bookmark;
@property (nonatomic, retain) IBOutlet UIButton *btn_search;
@property (nonatomic, retain) IBOutlet UIView *top_menu;
@property (nonatomic, retain) IBOutlet UIImageView *imgview_avatar;
@property (nonatomic, retain) IBOutlet UILabel *lbl_data;
@property (nonatomic, retain) IBOutlet UIButton *btn_open_profile;
@property (nonatomic, retain) IBOutlet UITextView *text_view;
@property (nonatomic, retain) IBOutlet UILabel *lbl_username;
@property (nonatomic, retain) IBOutlet UIView *current_tweet_view;
@property (nonatomic, retain) IBOutlet UILabel *lbl_description;
@property (nonatomic, retain) IBOutlet UIView *tweets_view;
  //Tweet,Retweet,Mention,DM
@property (nonatomic, retain) IBOutlet UIView *tweet_view;
@property (nonatomic, retain) IBOutlet UITextView *text_view_tweet_creation;
@property (retain, nonatomic) IBOutlet UITextField *txtUser;
@property (retain, nonatomic) IBOutlet UILabel *lbl_tweet_size;
@property (nonatomic, retain) IBOutlet UIButton *btn_tweet_action;
//Properties
@property (nonatomic,retain) Tweets *current_tweet;
@property (nonatomic,retain) TimelineContentViewController *tweets_table;
@property (nonatomic) TTAction action;
@property (nonatomic,assign) UINavigationController *navigation_controller;
@property (nonatomic,assign) NSString *share_text;
//IBActions
- (IBAction)openProfile:(id)sender;
- (IBAction)updateStatus:(id)sender;
//Methods
-(id)initWithAction:(TTAction)action andTweet:(Tweets *)tweet;
-(void)updateNewTweetViewLayout;
@end
