//
//  TwitterAccessor.h
//  SocialBOX
//
//  Created by Vitor Navarro on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAuthConsumer.h"
#import "Constants.h"
#import "SBJson.h"
#import "UIAlertView+UIAlertView_Helper.h"
#import "NSString+HTML.h"

@interface TwitterAccessor : NSObject {
  NSString *user_id;
  NSString *screen_name;
  
  id credentials_delegate;
}

@property (nonatomic,assign) BOOL valid_credentials;
@property (nonatomic,retain) OAToken *request_token;

-(OAToken *)getRequestToken;
-(void)saveRequestToken;
-(void)requestTokenWithDelegate:(id)parent;
-(void)requestAccessTokenWithDelegate:(id)parent;
-(void)accessTokenTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data;
-(void)accessTokenTicket:(OAServiceTicket *)ticket didFailWithError:(NSError *)error;

-(void)httpRequestTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data;
-(void)httpRequestTicket:(OAServiceTicket *)ticket didFailWithError:(NSError *)error;
-(void)verifyCredentialsTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data;
-(void) verifyCredentialsWithDelegate:(id)delegate;

-(void)makeRequestWithUrl:(NSString *)string_url andHttpMethod:(NSString *)http_method;
-(void)makeRequestWithUrl:(NSString *)string_url andHttpMethod:(NSString *)http_method andDelegate:(id)delegate withFinishedSelector:(SEL)selector;
- (void)sendStatus:(NSString *)status andDelegate:(id)delegate withFinishedSelector:(SEL)selector;
- (void)sendDM:(NSString *)status toUser:(NSString *)user andDelegate:(id)delegate withFinishedSelector:(SEL)selector;

-(BOOL)loadIsValidCredentials;

-(void)getHomeTimelineTo:(id)delegate andFinishedSelector:(SEL)selector;
-(void)getRetweetsTimeline:(id)delegate andFinishedSelector:(SEL)selector;
-(void)getMentionsTimeline:(id)delegate andFinishedSelector:(SEL)selector;
-(void)getDMsTimeline:(id)delegate andFinishedSelector:(SEL)selector;
-(void)getBookmarks:(id)delegate andFinishedSelector:(SEL)selector;
-(void)doRetweet:(NSString *)tweet_id;// withDelegate:(id)delegate andFinishedSelector:(SEL)selector;
-(void)doBookmark:(NSString *)tweet_id;
-(void)doUpdate:(NSString *)status;
-(void)doDM:(NSString *)status toUser:(NSString *)user;

+(TwitterAccessor *) sharedAccessor;
@end
