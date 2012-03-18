//
//  TwitterAccessor.m
//  SocialBOX
//
//  Created by Vitor Navarro on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterAccessor.h"


@implementation TwitterAccessor
@synthesize request_token =_request_token;
@synthesize valid_credentials;

-(void)showAlertWithMessage:(NSString *)message{
  UIAlertView *alert = [[[UIAlertView alloc]initWithTitle:@"Twitter" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,  nil]autorelease];
  [alert show];
}

-(void)showLoginErrorAlert{
  [self showAlertWithMessage:@"It was not possible to login, try again later..."];
}

-(void)showSuccessAlert{
  [self showAlertWithMessage:@"Operation completed with success."];
}

-(void)operationFinishedAlert:(BOOL)success withSuccessMessage:(NSString *)message andFailMessage:(NSString *)fail_message{
  if(success)
    [self showAlertWithMessage:message];
  else
    [self showAlertWithMessage:fail_message];

}


#pragma mark - Status (Tweets)


-(void)updateFinished:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data{
  [self operationFinishedAlert:ticket.didSucceed withSuccessMessage:@"Tweeted!" andFailMessage:@"Oops something went wrong..."];
  NSString *result = [[NSString alloc]initWithData:ticket.data encoding:NSUTF8StringEncoding];
  NSLog(@"%@ %@",result,ticket.request.URL);
}

-(void)doUpdate:(NSString *)status{  
  [self sendStatus:status andDelegate:self withFinishedSelector:@selector(updateFinished:didFinishWithData:)];
}

#pragma mark - Token Management
-(NSString *)getScreenName{
  if(screen_name == nil){
    screen_name = [[NSUserDefaults standardUserDefaults] valueForKey:@"twitter_screen_name"];
    if(screen_name == nil) screen_name = @"";
  }
  return screen_name;
}

-(void)saveScreenName{
  [[NSUserDefaults standardUserDefaults] setValue:screen_name forKey:@"twitter_screen_name"];
  [[NSUserDefaults standardUserDefaults]synchronize];
}

-(NSString *)getUserId{
  if(user_id == nil){
    user_id = [[NSUserDefaults standardUserDefaults] valueForKey:@"twitter_user_id"];
    if(user_id == nil) user_id = @"";
  }
  return user_id;
}

-(void)saveUserId{
  [[NSUserDefaults standardUserDefaults] setValue:user_id forKey:@"twitter_user_id"];
  [[NSUserDefaults standardUserDefaults]synchronize];
}

-(OAToken *)getRequestToken{
  if(self.request_token == nil)
    self.request_token = [[OAToken alloc]initWithUserDefaultsUsingServiceProviderName:@"twitter" prefix:@"socialbox"];
  return self.request_token;
}

-(void)saveRequestToken{
  [self.request_token storeInUserDefaultsWithServiceProviderName:@"twitter" prefix:@"socialbox"];
}

-(void)saveIsValidCredentials:(BOOL)is_valid_credentials{
  self.valid_credentials = is_valid_credentials;
  [[NSUserDefaults standardUserDefaults] setBool:self.valid_credentials forKey:@"twitter_is_valid"];
  [[NSUserDefaults standardUserDefaults]synchronize];
}

-(BOOL)loadIsValidCredentials{
  self.valid_credentials = [[NSUserDefaults standardUserDefaults] boolForKey:@"twitter_is_valid"];
  return self.valid_credentials;
}

#pragma mark - Request Tickets

- (void)requestTokenTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data {
  if (ticket.didSucceed) {
    NSString *response_body = [[[NSString alloc] initWithData:data
                                                   encoding:NSUTF8StringEncoding]autorelease];
    self.request_token = [[OAToken alloc] initWithHTTPResponseBody:response_body];
    [self saveRequestToken];
  }
}

-(void)accessTokenTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data{
  if (ticket.didSucceed) {
    NSString *responseBody = [[[NSString alloc] initWithData:data
                                                   encoding:NSUTF8StringEncoding]autorelease];
    NSLog(@"ResponseBody:%@",responseBody);
    NSLog(@"Request token w/ access:%@",self.request_token);
    NSRange user_id_range = [responseBody rangeOfString:@"user_id="];
    NSRange screen_name_range = [responseBody rangeOfString:@"screen_name="];
    if(user_id_range.location != NSNotFound && screen_name_range.location != NSNotFound){
      user_id = [responseBody  substringFromIndex:user_id_range.location+user_id_range.length];
      user_id =  [[user_id componentsSeparatedByString:@"&"] objectAtIndex:0];
      screen_name = [responseBody substringFromIndex:screen_name_range.location+screen_name_range.length];
      NSLog(@"User id:%@",user_id);
      NSLog(@"Screen Name:%@",screen_name);
      [self saveScreenName];
      [self saveUserId];
      NSRange oauth_token = [responseBody rangeOfString:@"oauth_token="];
      NSString *token = [responseBody  substringFromIndex:oauth_token.location+oauth_token.length];
      token =  [[token componentsSeparatedByString:@"&"] objectAtIndex:0];
      [self.request_token setKey:token];
      NSRange oauth_token_secret=[responseBody rangeOfString:@"oauth_token_secret="];
      NSString *secret = [responseBody substringFromIndex:oauth_token_secret.location+oauth_token_secret.length];
      secret =  [[secret componentsSeparatedByString:@"&"] objectAtIndex:0];
      [self.request_token setSecret:secret];
      [self saveIsValidCredentials:YES];
      [self saveRequestToken];
    }
  }
}
  
-(void)accessTokenTicket:(OAServiceTicket *)ticket didFailWithError:(NSError *)error{
  [self showLoginErrorAlert];
}

-(void)httpRequestTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data{
  if(ticket.didSucceed){
    NSString *responseBody = [[[NSString alloc] initWithData:ticket.data
                                                   encoding:NSUTF8StringEncoding]autorelease];
    NSLog(@"%@",[responseBody JSONValue]);
  }
}

-(void)httpRequestTicket:(OAServiceTicket *)ticket didFailWithError:(NSError *)error{
  NSLog(@"Http Request Error:%@",error);
  [self showLoginErrorAlert];
}

-(void)verifyCredentialsTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data{
  if(ticket.didSucceed) {
    [self saveIsValidCredentials:YES];

    NSString *responseBody = [[[NSString alloc] initWithData:ticket.data
                                                    encoding:NSUTF8StringEncoding]autorelease];
    NSLog(@"%@",responseBody);
    
    [self requestTokenWithDelegate:credentials_delegate];     
//    [((UIViewController *)credentials_delegate).navigationController popViewControllerAnimated:YES];
  }
  else{
    [self saveIsValidCredentials:NO];
    NSString *responseBody = [[[NSString alloc] initWithData:ticket.data
                                                   encoding:NSUTF8StringEncoding]autorelease];
    id json = [responseBody JSONValue];
    if([json isKindOfClass:[NSDictionary class]]){    
      NSLog(@"%@",[json objectForKey:@"error"]);
      NSLog(@"%@",[json objectForKey:@"request"]);
    }   
    [self requestTokenWithDelegate:credentials_delegate]; 
  }
}

#pragma mark - Token Processing (Request/Auth/Access)

//Unauthorized Token
-(void)requestTokenWithDelegate:(id)parent{

  OAConsumer *consumer = [[[OAConsumer alloc] initWithKey:TWITTER_KEY
                                                  secret:TWITTER_SECRET]autorelease];
  
  NSURL *url = [NSURL URLWithString:TWITTER_REQUEST_TOKEN_URL];
  
  OAMutableURLRequest *request = [[[OAMutableURLRequest alloc] initWithURL:url
                                                                 consumer:consumer
                                                                    token:nil   // we don't have a Token yet
                                                                    realm:@"http://api.twitter.com"   // our service provider doesn't specify a realm
                                                        signatureProvider:nil]autorelease]; // use the default method, HMAC-SHA1
  
  [request setHTTPMethod:@"POST"];
  
  OADataFetcher *fetcher = [[[OADataFetcher alloc] init]autorelease];
  
  if(parent == nil) parent = self;
    
  [fetcher fetchDataWithRequest:request
                       delegate:parent
              didFinishSelector:@selector(requestTokenTicket:didFinishWithData:)
                didFailSelector:@selector(requestTokenTicket:didFailWithError:)];
  
}

//Get acces token with unauth token
-(void)requestAccessTokenWithDelegate:(id)parent{
  OAConsumer *consumer = [[[OAConsumer alloc] initWithKey:TWITTER_KEY
                                                  secret:TWITTER_SECRET]autorelease];
  
  NSURL *url = [NSURL URLWithString:TWITTER_ACCESS_TOKEN_URL];
  
  OAMutableURLRequest *request = [[[OAMutableURLRequest alloc] initWithURL:url
                                                                 consumer:consumer
                                                                    token:[self getRequestToken]   // we don't have a Token yet
                                                                    realm:@"http://api.twitter.com"   // our service provider doesn't specify a realm
                                                        signatureProvider:nil]autorelease]; // use the default method, HMAC-SHA1
  [request setHTTPMethod:@"POST"];
  
  OADataFetcher *fetcher = [[[OADataFetcher alloc] init]autorelease];
  
  if(parent == nil) parent = self;
  
  [fetcher fetchDataWithRequest:request
                       delegate:parent
              didFinishSelector:@selector(accessTokenTicket:didFinishWithData:)
                didFailSelector:@selector(accessTokenTicket:didFailWithError:)];
  
}

-(void) verifyCredentialsWithDelegate:(id)delegate{
  credentials_delegate = delegate;
  //NSLog(@"Request Token:%@",[self getRequestToken]);
  NSString *credentials_screen_name = [self getScreenName];
  if(credentials_screen_name != nil && credentials_screen_name != @""){
    NSString *urltest = [NSString stringWithFormat:@"http://api.twitter.com/1/account/verify_credentials.json?screen_name=%@",credentials_screen_name];    
    [self makeRequestWithUrl:urltest andHttpMethod:@"GET" andDelegate:self withFinishedSelector:@selector(verifyCredentialsTicket:didFinishWithData:)];
  }
  else if(delegate != nil)
    [self requestTokenWithDelegate:credentials_delegate]; 
}

-(void)makeRequestWithUrl:(NSString *)string_url andHttpMethod:(NSString *)http_method{
  [self makeRequestWithUrl:string_url andHttpMethod:http_method
               andDelegate:self withFinishedSelector:@selector(httpRequestTicket:didFinishWithData:)];
}

-(void)makeRequestWithUrl:(NSString *)string_url andHttpMethod:(NSString *)http_method 
              andDelegate:(id)delegate withFinishedSelector:(SEL)selector{
  OAConsumer *consumer = [[[OAConsumer alloc] initWithKey:TWITTER_KEY
                                                  secret:TWITTER_SECRET]autorelease];
  
  NSURL *url = [NSURL URLWithString:[string_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  
  NSLog(@"%@",[string_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
  
  NSLog(@"Request Token: %@",[self getRequestToken]);
  
  OAMutableURLRequest *request = [[[OAMutableURLRequest alloc] initWithURL:url
                                                                 consumer:consumer
                                                                    token:[self getRequestToken]   // we don't have a Token yet
                                                                    realm:@"http://api.twitter.com"   // our service provider doesn't specify a realm
                                                        signatureProvider:nil]autorelease]; // use the default method, HMAC-SHA1
  [request setHTTPMethod:http_method];
  
  OADataFetcher *fetcher = [[[OADataFetcher alloc] init]autorelease];
  
  [fetcher fetchDataWithRequest:request
                       delegate:delegate
                didFinishSelector:selector
                  didFailSelector:@selector(httpRequestTicket:didFailWithError:)];
              //didFinishSelector:@selector(httpRequestTicket:didFinishWithData:)
              //  didFailSelector:@selector(httpRequestTicket:didFailWithError:)];
  
}

- (void)sendStatus:(NSString *)status andDelegate:(id)delegate withFinishedSelector:(SEL)selector
{
  OAConsumer *consumer = [[[OAConsumer alloc] initWithKey:TWITTER_KEY
                                                   secret:TWITTER_SECRET]autorelease];
  
	OAMutableURLRequest *oRequest = [[OAMutableURLRequest alloc] initWithURL:[NSURL URLWithString:TWITTER_UPDATE_URL]
                                                                  consumer:consumer
                                                                     token:[self getRequestToken]
                                                                     realm:nil
                                                         signatureProvider:nil];
  
	[oRequest setHTTPMethod:@"POST"];
  
	OARequestParameter *statusParam = [[[OARequestParameter alloc] initWithName:@"status" value:status]autorelease];
	NSArray *params = [NSArray arrayWithObjects:statusParam, nil];
	[oRequest setParameters:params];
  
	OADataFetcher *fetcher = [[[OADataFetcher  alloc]init]autorelease];
  [fetcher fetchDataWithRequest:oRequest
                       delegate:delegate
              didFinishSelector:selector
                didFailSelector:@selector(httpRequestTicket:didFailWithError:)];
}

#pragma mark - Lifecycle

static TwitterAccessor *shared_instance;

+(TwitterAccessor *) sharedAccessor {
  
  @synchronized(self) {
    if (!shared_instance)
			shared_instance = [[TwitterAccessor alloc] init];
  }
  return shared_instance;
}

- (id)init {
  self = [super init];
  if (self) {
    [self loadIsValidCredentials];
    [self getRequestToken];
  }
  return self;
}

-(void)dealloc{
  [user_id release];
  [screen_name release];
  [_request_token release];
  [super dealloc];
}

@end
