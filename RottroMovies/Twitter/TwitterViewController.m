//
//  TwitterViewController.m
//  SocialBOX
//
//  Created by Vitor Navarro on 8/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterViewController.h"
#import "ContainerViewController.h"

@implementation TwitterViewController
@synthesize lbl_data;
@synthesize btn_open_profile;
@synthesize text_view;
@synthesize lbl_username;
@synthesize current_tweet_view;
@synthesize tweet_view;
@synthesize lbl_description;
@synthesize tweets_view;
@synthesize btn_retweet;
@synthesize btn_mention;
@synthesize btn_direct_message;
@synthesize btn_bookmark;
@synthesize btn_search;
@synthesize top_menu;
@synthesize imgview_avatar;
@synthesize text_view_tweet_creation;
@synthesize txtUser;
@synthesize lbl_tweet_size;
@synthesize btn_tweet_action;
@synthesize current_tweet;
@synthesize tweets_table =_tweets_table;
@synthesize action = _action;
@synthesize navigation_controller = _navigation_controller;
@synthesize share_text=_share_text;


-(void)retweet{
  [[TwitterAccessor sharedAccessor] doRetweet:self.current_tweet.tweet_id];
}

-(void)bookmark{
  [[TwitterAccessor sharedAccessor] doBookmark:self.current_tweet.tweet_id];
}

#pragma mark - Alert
-(void)showAlert:(NSDictionary *)alert{
  UIAlertView *alert_view = [[[UIAlertView alloc]initWithTitle:[alert objectForKey:@"title"] 
                                                      message:[alert objectForKey:@"message"] 
                                                     delegate:self 
                                            cancelButtonTitle:[alert objectForKey:@"cancel"] 
                                            otherButtonTitles:[alert objectForKey:@"ok"],  nil]autorelease];
  [alert_view show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
  NSString *button_title = [alertView buttonTitleAtIndex:buttonIndex];
  if([button_title isEqualToString:@"retweet"]){
    [self retweet];
  }
  if([button_title isEqualToString:@"favorite"]){
    [self bookmark];
  }
}

#pragma mark - TTSocialBarDelegate

-(void)openTwitterContainerWithAction:(TTAction)tt_action andTweet:(Tweets *)tweet{
  ContainerViewController *retweets_container = [[[ContainerViewController alloc]init]autorelease];
  retweets_container.container_type = TwitterContainer;
  retweets_container.twitter_action = tt_action;
  retweets_container.tweet = tweet;
  
  [self.navigation_controller pushViewController:retweets_container animated:YES]; 
}

-(void)doRetweet{
  if(self.current_tweet){
    [self showAlert:[NSDictionary dictionaryWithObjectsAndKeys:@"Twitter",@"title",
                     @"Retweet this?",@"message",
                     @"cancel",@"cancel",
                     @"retweet",@"ok",nil]];
  }
}

-(void)doMention{
  [self openTwitterContainerWithAction:Mention andTweet:self.current_tweet];
}

-(void)doDM{
  [self openTwitterContainerWithAction:DirectMessage andTweet:self.current_tweet];  
}

-(void)doBookmark{
  if(self.current_tweet){
    [self showAlert:[NSDictionary dictionaryWithObjectsAndKeys:@"Twitter",@"title",
                     @"Favorite this?",@"message",
                     @"cancel",@"cancel",
                     @"favorite",@"ok",nil]];
  }
}

-(void)openBookmarks{
  [self openTwitterContainerWithAction:TableBooks andTweet:nil];
}

-(void)openDMs{
  [self openTwitterContainerWithAction:TableDMs andTweet:nil];
}

-(void)openMentions{
  [self openTwitterContainerWithAction:TableMentions andTweet:nil];
}

-(void)openRetweets{
  [self openTwitterContainerWithAction:TableRts andTweet:nil];
}

-(void)search{
  
}

#pragma mark - Actions

-(void)openProfile:(id)sender{
  
}

- (IBAction)updateStatus:(id)sender {
  if (self.action == DirectMessage)
    [[TwitterAccessor sharedAccessor] doDM:self.text_view_tweet_creation.text toUser:self.txtUser.text];
  else
    [[TwitterAccessor sharedAccessor] doUpdate:self.text_view_tweet_creation.text];
}

#pragma mark - Timeline Cell Delegate

- (void)timelineCellTouchedTweet:(Tweets *)tweet{  
  ContainerViewController *current_tweet_container = [[[ContainerViewController alloc]init]autorelease];
  current_tweet_container.container_type = TwitterContainer;
  current_tweet_container.twitter_action = CurrentTweet;
  current_tweet_container.tweet = tweet;
  [self.navigation_controller pushViewController:current_tweet_container animated:YES];
}

-(void)timelineCellTouchedMention:(Tweets *)tweet{
  ContainerViewController *current_tweet_container = [[[ContainerViewController alloc]init]autorelease];
  current_tweet_container.container_type = TwitterContainer;
  current_tweet_container.twitter_action = Mention;
  current_tweet_container.tweet = (Tweets *)tweet;
  [self.navigation_controller pushViewController:current_tweet_container animated:YES];
}

#pragma  mark - TopMenu Delegate
-(void)leftButton:(TopMenuAction)menu_action{
  [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightButton:(TopMenuAction)menu_action{
  self.action = NewTweet;
  
}

#pragma mark - Layout

-(void)updateTextSize:(UITextView *)textView{
  NSInteger actual_count = 140-[textView.text length];
  [self.lbl_tweet_size setText:[NSString stringWithFormat:@"%d",actual_count]];
  if(actual_count < 0)
    [self.lbl_tweet_size setTextColor:[UIColor redColor]];
  else
    [self.lbl_tweet_size setTextColor:[UIColor whiteColor]];    
}

-(void)updateNewTweetViewLayout{
  [self.txtUser setHidden:YES];
  switch (self.action) {
    case NewTweet:
      [self.text_view_tweet_creation setText:@"What`s happening?"];
      [self.btn_tweet_action setTitle:@"Tweet it" forState:UIControlStateNormal];
      break;
    case TTShareExternal:
      [self.text_view_tweet_creation setText:self.share_text];
      [self.btn_tweet_action setTitle:@"Share" forState:UIControlStateNormal];
      break;
    case Retweet:
      [self.text_view_tweet_creation setText:[NSString stringWithFormat:@"RT @%@:%@",
                                              self.current_tweet.name,self.current_tweet.text]];      
      [self.btn_tweet_action setTitle:@"Retweet it" forState:UIControlStateNormal];      
      break;
    case Mention:
      if(self.current_tweet) [self.text_view_tweet_creation setText:[NSString stringWithFormat:@"@%@", self.current_tweet.name]];      
      [self.btn_tweet_action setTitle:@"Mention it" forState:UIControlStateNormal];
      break;
    case DirectMessage:
      [self.txtUser setHidden:NO];
      [self.btn_tweet_action setTitle:@"Send direct message" forState:UIControlStateNormal];
      break;
    default:
      break;
  }
  if (![self.text_view_tweet_creation.text isEqualToString:@"What`s happening?"])
    [self updateTextSize:self.text_view_tweet_creation];
}

-(void)loadTweetsTableView{
  self.tweets_table = [[[TimelineContentViewController alloc]init]autorelease];
  [self.tweets_table setDelegate:self];
  [[TwitterAccessor sharedAccessor] getHomeTimelineTo:self.tweets_table 
              andFinishedSelector:@selector(loadTwitterData:didFinishWithData:)];
  [self.tweets_view addSubview:self.tweets_table.view];  
  [self.tweets_view setHidden:NO];
}

-(void)loadRetweetsTableView{
  self.tweets_table = [[[TimelineContentViewController alloc]init]autorelease];
  [self.tweets_table setDelegate:self];
  [[TwitterAccessor sharedAccessor] getRetweetsTimeline:self.tweets_table 
                                  andFinishedSelector:@selector(loadTwitterData:didFinishWithData:)];
  [self.tweets_view addSubview:self.tweets_table.view];  
  [self.tweets_view setHidden:NO];
}

-(void)loadMentionsTableView{
  self.tweets_table = [[[TimelineContentViewController alloc]init]autorelease];
  [self.tweets_table setDelegate:self];
  [[TwitterAccessor sharedAccessor] getMentionsTimeline:self.tweets_table 
                                    andFinishedSelector:@selector(loadTwitterData:didFinishWithData:)];
  [self.tweets_view addSubview:self.tweets_table.view];  
  [self.tweets_view setHidden:NO];
}

-(void)loadDMsTableView{
  self.tweets_table = [[[TimelineContentViewController alloc]init]autorelease];
  [self.tweets_table setDelegate:self];
  [[TwitterAccessor sharedAccessor] getDMsTimeline:self.tweets_table 
                                    andFinishedSelector:@selector(loadDMsData:didFinishWithData:)];
  [self.tweets_view addSubview:self.tweets_table.view];  
  [self.tweets_view setHidden:NO];
}

-(void)loadBooksTableView{
  self.tweets_table = [[[TimelineContentViewController alloc]init]autorelease];
  [self.tweets_table setDelegate:self];
  [[TwitterAccessor sharedAccessor] getBookmarks:self.tweets_table 
                               andFinishedSelector:@selector(loadTwitterData:didFinishWithData:)];
  [self.tweets_view addSubview:self.tweets_table.view];  
  [self.tweets_view setHidden:NO];
}


-(void)loadCurrentTweetView{
    [self.text_view setText:self.current_tweet.text];
    [self.lbl_username setText:self.current_tweet.name];    
    [self.current_tweet_view setHidden:NO];
}

-(void)loadTweetView{
  [self updateNewTweetViewLayout];
  [self.tweet_view setHidden:NO];
}

-(void)loadViewForAction{
  switch (self.action) {
    case TableTweets:
      [self loadTweetsTableView];
      break;
    case CurrentTweet:
      [self loadCurrentTweetView];
      break;
    case TableRts:
      [self loadRetweetsTableView];
      break;
    case TableMentions:
      [self loadMentionsTableView];
      break;
    case TableDMs:
      [self loadDMsTableView];
      break;
    case TableBooks:
      [self loadBooksTableView];
      break;
    default:
      [self loadTweetView];
      break;
  }
}

#pragma mark - TextView Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
  if ([textView.text isEqualToString:@"What`s happening?"])[textView setText:@""];
  else if (self.action != Mention && self.action != Retweet && self.action != DirectMessage) [textView setText:@""];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
  if([textView.text isEqualToString:@""]) 
    [textView setText:@"What`s happening?"];
}

- (void)textViewDidChange:(UITextView *)textView{
  NSLog(@"%@ %d",textView.text,[textView.text length]);  
  [self updateTextSize:textView];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
  if ([text isEqualToString:@"\n"]) {
    [textView resignFirstResponder];
    return FALSE;
  }
  return TRUE;
}

#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
  [textField resignFirstResponder];
  [self.text_view_tweet_creation becomeFirstResponder];
  return TRUE;
}



#pragma mark - View lifecycle

-(id)initWithAction:(TTAction)action andTweet:(Tweets *)tweet{
  self = [super init];
  if(self){
    self.current_tweet = tweet;
    self.action = action;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self loadViewForAction];
}

-(void)viewWillAppear:(BOOL)animated{
}

- (void)viewDidUnload
{
  self.tweets_table = nil;
  [self setBtn_retweet:nil];
  [self setBtn_mention:nil];
  [self setBtn_direct_message:nil];
  [self setBtn_bookmark:nil];
  [self setBtn_search:nil];
  [self setImgview_avatar:nil];
  [self setLbl_username:nil];
  [self setLbl_description:nil];
  [self setText_view:nil];
  [self setLbl_data:nil];
  [self setCurrent_tweet_view:nil];
  [self setTweets_view:nil];
  [self setTweet_view:nil];
  [self setText_view_tweet_creation:nil];
  [self setBtn_tweet_action:nil];
    [self setBtn_open_profile:nil];
  [self setLbl_tweet_size:nil];
  [self setTxtUser:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
  [_tweets_table release];
  [top_menu release];
  [btn_retweet release];
  [btn_mention release];
  [btn_direct_message release];
  [btn_bookmark release];
  [btn_search release];
  [imgview_avatar release];
  [lbl_username release];
  [lbl_description release];
  [text_view release];
  [lbl_data release];
  [current_tweet_view release];
  [tweets_view release];
  [tweet_view release];
  [text_view_tweet_creation release];
  [btn_tweet_action release];
    [btn_open_profile release];
  [lbl_tweet_size release];
  [txtUser release];
  [super dealloc];
}


- (void)didReceiveMemoryWarning
{
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}
@end
