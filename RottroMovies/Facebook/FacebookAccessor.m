//
//  FacebookAccessor.m
//  SocialBOX
//
//  Created by Vitor Navarro on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FacebookAccessor.h"

@implementation FacebookAccessor

@synthesize facebook = _facebook;
@synthesize me =_me;

#pragma mark - Facebook data

-(void)getPosts:(id<FBRequestDelegate>)delegate{
  [self.facebook requestWithGraphPath:@"me/home" andDelegate:delegate];
}

-(void)getImageFromUser:(NSString *)user_id withDelegate:(id<FBRequestDelegate>)delegate{
  [self.facebook requestWithGraphPath:[NSString stringWithFormat:@"%@/picture",user_id] andDelegate:delegate];
}

-(void)likePost:(NSString *)post_id withDelegate:(id<FBRequestDelegate>)delegate{
  NSLog(@"%@",post_id);
  [self.facebook requestWithGraphPath:[NSString stringWithFormat:@"%@/likes",post_id] andParams:[NSMutableDictionary dictionary] andHttpMethod:@"POST" andDelegate:delegate];
}

-(void)unlikePost:(NSString *)post_id{
  [self.facebook requestWithGraphPath:[NSString stringWithFormat:@"%@/likes",post_id] andParams:[NSMutableDictionary dictionary] andHttpMethod:@"DELETE" andDelegate:nil];
}

-(void)getMeWithParams:(NSMutableDictionary *)params andDelegate:(id<FBRequestDelegate>)delegate{  
  [self.facebook requestWithGraphPath:@"me" andParams:params andDelegate:delegate];
}

-(BOOL)didILikeApost:(NSMutableArray *)likes{
  if (!self.me) return NO;
  Like *found = nil;
  for (Like *like in likes) {
    NSLog(@"%@ %@",like.name,self.me.name);
    if([like.name isEqualToString:self.me.name]) found = like;
  }
  [likes removeObject:found];
  return found != nil;
}

-(void)loadMeUser{
  if([self isCredentialsValid])
    [self getMeWithParams:[NSMutableDictionary dictionaryWithObject:@"name" forKey:@"fields"]andDelegate:self];
}

-(void)comment:(NSString *)comment inPost:(NSString *)status_id andDelegate:(id<FBRequestDelegate>)delegate{
  [self.facebook requestWithGraphPath:[NSString stringWithFormat:@"%@/comments",status_id] andParams:[NSMutableDictionary dictionaryWithObject:comment forKey:@"message"] andHttpMethod:@"POST" andDelegate:delegate];
}

#pragma mark -

-(void)saveAccessToken{
  NSLog(@"%@",self.facebook);
  [[NSUserDefaults standardUserDefaults] setObject:self.facebook.accessToken forKey:FACEBOOK_ACESS_TOKEN_KEY_USER];
  [[NSUserDefaults standardUserDefaults] setObject:self.facebook.expirationDate forKey:FACEBOOK_EXPIRE_DATE_KEY_USER];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)loadAccessToken{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  if ([defaults objectForKey:FACEBOOK_ACESS_TOKEN_KEY_USER] 
      && [defaults objectForKey:FACEBOOK_ACESS_TOKEN_KEY_USER]) {
    self.facebook.accessToken = [defaults objectForKey:FACEBOOK_ACESS_TOKEN_KEY_USER];
    self.facebook.expirationDate = [defaults objectForKey:FACEBOOK_EXPIRE_DATE_KEY_USER];
  }
}

-(void)validateCredentials{
  if (![self.facebook isSessionValid]) {
    permissions =  [[NSArray arrayWithObjects:@"read_stream", @"publish_stream",@"offline_access",nil] retain];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:FACEBOOK_KEY,@"client_id",@"read_stream,publish_stream,user_activities",@"scope",@"http://www.vnavarro.com.br",@"redirect_uri", nil];
    [[NSNotificationCenter defaultCenter] addObserver:self.facebook selector:@selector(saveAccessToken) name:@"accessToken" object:nil] ;
    [self.facebook dialog:@"oauth" andParams:parameters andDelegate:self];
    //[self.facebook authorize:permissions delegate:self];
  }
}

-(BOOL)isCredentialsValid{
  NSLog(@"%@",self.facebook.accessToken);
  NSLog(@"%@",self.facebook.expirationDate);
  return [self.facebook isSessionValid];
}

-(BOOL)handleUrl:(NSURL *)url{
  return [self.facebook handleOpenURL:url];
}

-(void)dialogCompleteWithUrl:(NSURL *)url{
  NSLog(@"%@",url);  
}

-(void)dialogDidComplete:(FBDialog *)dialog{
  NSLog(@"%@",dialog);
}

- (void)fbDidLogin {
  [self saveAccessToken];
  [[NSNotificationCenter defaultCenter] postNotificationName:CHANGE_FACEBOOK_BUTTON object:nil];
}

-(void)fbDialogLogin:(NSString *)token expirationDate:(NSDate *)expirationDate{
  NSLog(@"Token:%@ ExpirationDate:%@",token,expirationDate);
}

-(void)fbDialogNotLogin:(BOOL)cancelled{
  NSLog(@"Didnt dialog login");
}

-(void)fbDidNotLogin:(BOOL)cancelled{
  self.facebook.accessToken = nil;
  self.facebook.expirationDate = nil;
  NSLog(@"porra");
}
-(void)fbDidLogout{
  NSLog(@"logaout porra");  
}
-(void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"%@",request);
  NSLog(@"%@",response);
}

-(void)request:(FBRequest *)request didLoad:(id)result{
  if([[request url]isEqualToString:@"https://graph.facebook.com/me"]){
    self.me = [FacebookParser parseUser:result];  
  }
  NSLog(@"%@",request);
  NSLog(@"%@",result);  
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
  NSLog(@"%@",[error localizedDescription]);
}

- (void)dialogDidNotCompleteWithUrl:(NSURL *)url{
  NSLog(@"Error 1:%@",url);
}


- (void)dialogDidNotComplete:(FBDialog *)dialog{
    NSLog(@"Error 2:%@",dialog);
}

- (void)dialog:(FBDialog*)dialog didFailWithError:(NSError *)error{
    NSLog(@"Error 3:%@",error);
}

- (id)init {
  self = [super init];
  if (self) {
    self.facebook = [[Facebook alloc] initWithAppId:FACEBOOK_KEY];
    [self.facebook setSessionDelegate:self];
    [self loadAccessToken];
  }
  return self;
}
     
static FacebookAccessor *shared_instance;

+(FacebookAccessor *) sharedAccessor { 
   @synchronized(self) {
     if (!shared_instance)
       shared_instance = [[FacebookAccessor alloc] init];
   }
   return shared_instance;
}


- (void)dealloc {
  [permissions release];
  [_facebook release];
  [_me release];
  [super dealloc];
}

@end
