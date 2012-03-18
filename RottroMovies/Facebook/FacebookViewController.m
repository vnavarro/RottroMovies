//
//  FacebookViewController.m
//  SocialBOX
//
//  Created by Vitor Navarro on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FacebookViewController.h"
#import "ContainerViewController.h"

@implementation FacebookViewController
@synthesize feed_view;
@synthesize status_view;
@synthesize status_text;
@synthesize btn_send;
@synthesize current_status_view;
@synthesize avatar_view;
@synthesize btn_open_avatar;
@synthesize lbl_username;
@synthesize lbl_description;
@synthesize feed_text;
@synthesize action = _action;
@synthesize fb_table = _fb_table;
@synthesize navigation_controller = _navigation_controller;
@synthesize current_feed = _current_feed;
@synthesize share_text=_share_text;

-(void)alertViewWithMessage:(NSString *)message{
  UIAlertView *alert = [[[UIAlertView alloc]initWithTitle:@"Facebook" message:message delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil]autorelease];
  [alert show];
}

#pragma  mark - TopMenu Delegate
-(void)leftButton:(TopMenuAction)menu_action{
  [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightButton:(TopMenuAction)menu_action{
  ContainerViewController *comment = [[[ContainerViewController alloc]init]autorelease];
  comment.container_type = FacebookContainer;
  comment.fb_action = FBStatus;
  [self.navigation_controller pushViewController:comment animated:YES];
}

#pragma mark - Bar delegate

-(void)likeStatus{
  if(!self.current_feed){
    [self alertViewWithMessage:@"Select a post to like"];
  }
  else{
    if([[FacebookAccessor sharedAccessor] didILikeApost:[self.current_feed likes]])
      [[FacebookAccessor sharedAccessor] unlikePost:[self.current_feed post_id]];
    else{
      Like *like = [[[Like alloc]init]autorelease];
      like.user_id = [[[FacebookAccessor sharedAccessor] me]user_id];
      like.name = [[[FacebookAccessor sharedAccessor] me]name];
      [[self.current_feed likes]addObject:like];
      [[FacebookAccessor sharedAccessor] likePost:[self.current_feed post_id] withDelegate:nil];
    }
  }
}

-(void)commentStatus{
  if(!self.current_feed){
    [self alertViewWithMessage:@"Select a post to comment"];
  }
  else
    [self timelineCellTouchedFbComment:self.current_feed];
}

-(void)shareStatus{
  if(!self.current_feed){
    [self alertViewWithMessage:@"Select a post to share"];
  }
  else{
    ContainerViewController *status = [[[ContainerViewController alloc]init]autorelease];
    status.container_type = FacebookContainer;
    status.fb_action = FBShare;
    status.current_feed = self.current_feed;
    [self.navigation_controller pushViewController:status animated:YES];
  }
}

- (IBAction)sendStatus:(id)sender {
  if(sendingStatus) return;
  [SVProgressHUD show];
  [[FacebookAccessor sharedAccessor] comment:self.status_text.text inPost:self.current_feed.post_id andDelegate:self];
  sendingStatus = YES;
}

-(void)request:(FBRequest *)request didFailWithError:(NSError *)error {
  NSLog(@"%@", [error localizedDescription]);
  NSLog(@"Err details: %@", [error description]);  
  [SVProgressHUD dismissWithSuccess:@"Oops...something went wrong!"];  
}

-(void)request:(FBRequest *)request didLoad:(id)result{
  [SVProgressHUD dismissWithSuccess:@"Success!"];  
  sendingStatus = NO;
}

#pragma mark - TextView Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
  [textView setText:@""];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
  if([textView.text isEqualToString:@""] && !self.current_feed) 
    [textView setText:@"What` on your mind?"];
  else if(self.action == FBComment && [textView.text isEqualToString:@""]){
    [textView setText:@"Write a comment"];
  }
}

- (void)textViewDidChange:(UITextView *)textView{
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

#pragma mark - Cell Delegate
-(void)timelineCellTouchedFbStatus:(FBCustomPost *)post{
  ContainerViewController *status = [[[ContainerViewController alloc]init]autorelease];
  status.container_type = FacebookContainer;
  status.fb_action = FBShowFeed;
  status.current_feed = post;
  [self.navigation_controller pushViewController:status animated:YES];
}

-(void)timelineCellTouchedFbComment:(FBCustomPost *)post{
  ContainerViewController *comment = [[[ContainerViewController alloc]init]autorelease];
  comment.container_type = FacebookContainer;
  comment.fb_action = FBComment;
  comment.current_feed = post;
  [self.navigation_controller pushViewController:comment animated:YES];
}

#pragma mark - Loads

-(void)loadFeeds{
  self.fb_table = [[[TimelineContentViewController alloc]init]autorelease];
  [self.fb_table setDelegate:self];
  [[FacebookAccessor sharedAccessor]getPosts:self.fb_table];
  [self.feed_view addSubview:self.fb_table.view];  
  [self.feed_view setHidden:NO];
}

-(void)loadStatus{
  [self.status_view setHidden:NO];
}

-(void)loadSingleFeed{
  [self.feed_text setText:self.current_feed.text];
  [self.lbl_username setText:self.current_feed.from_name];
  [self.avatar_view setImageWithURL:[NSURL URLWithString:self.current_feed.avatar_url]];
  [self.current_status_view setHidden:NO];
}

-(void)loadViewForAction{
  switch (self.action) {
    case FBFeed:      
      [self loadFeeds];
      break;      
    case FBShowFeed:
      [self loadSingleFeed];
      break;
    case FBShare:
      [self loadStatus];
      [self.status_text setText:self.current_feed.text];
      break;
    case FBStatus:
      [self loadStatus];      
      break;
    case FBComment:
      [self loadStatus];
      [self.status_text setText:@"Write a comment"];
      break;
    case FBShareExternal:
      [self loadStatus];
      [self.status_text setText:self.share_text];
      [self.btn_send setTitle:@"Share" forState:UIControlStateNormal];
      break;
  }
}

#pragma mark - View lifecycle

-(id)initWithAction:(FBAction)action{
  self = [super init];
  if(self){
    self.action = action;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self loadViewForAction];
}

- (void)viewDidUnload
{
  self.current_feed = nil;
  self.fb_table = nil;
  [self setFeed_view:nil];
  [self setStatus_view:nil];
  [self setStatus_text:nil];
  [self setBtn_send:nil];
  [self setCurrent_status_view:nil];
  [self setAvatar_view:nil];
  [self setBtn_open_avatar:nil];
  [self setLbl_username:nil];
  [self setLbl_description:nil];
  [self setFeed_text:nil];
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
  [_current_feed release];
  [_fb_table release];
  [feed_view release];
  [status_view release];
  [status_text release];
  [btn_send release];
  [current_status_view release];
  [avatar_view release];
  [btn_open_avatar release];
  [lbl_username release];
  [lbl_description release];
  [feed_text release];
  [super dealloc];
}

@end
