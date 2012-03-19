//
//  FacebookAccessor.m
//  RottroMovies
//
//  Created by Vitor Navarro on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FacebookAccessor.h"

@implementation FacebookAccessor

@synthesize facebook = _facebook;
@synthesize delegate=_delegate;

#pragma mark - Facebook data

-(void)comment:(NSString *)comment andDelegate:(id<FBRequestDelegate>)delegate{
  [self.facebook requestWithGraphPath:@"me/feed" andParams:[NSMutableDictionary dictionaryWithObject:comment forKey:@"message"] andHttpMethod:@"POST" andDelegate:delegate];
}

#pragma mark - Token Control

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

-(void)validateCredentials:(id<FacebookLoginDelegate>)delegate{
  if (![self.facebook isSessionValid]) {
    permissions =  [[NSArray arrayWithObjects:@"read_stream", @"publish_stream",@"offline_access",nil] retain];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:FACEBOOK_KEY,@"client_id",@"read_stream,publish_stream,user_activities",@"scope",@"http://www.vnavarro.com.br",@"redirect_uri", nil];
    [[NSNotificationCenter defaultCenter] addObserver:self.facebook selector:@selector(saveAccessToken) name:@"accessToken" object:nil] ;
    self.delegate = delegate;
    [self.facebook dialog:@"oauth" andParams:parameters andDelegate:self];
  }
}

-(BOOL)isCredentialsValid{
  NSLog(@"%@",self.facebook.accessToken);
  NSLog(@"%@",self.facebook.expirationDate);
  return [self.facebook isSessionValid];
}

#pragma mark - Facebook Delegates

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
  [self.delegate onFbAccessorLogin];
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
  [self.delegate onFbAccessorLoginError];
}

-(void)fbDidLogout{

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

#pragma mark - Lifecycle

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
  [super dealloc];
}

@end
