//
//  TwitterAuthViewController.m
//  RottroMovies
//
//  Created by Vitor Navarro on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  Altered by Vitor Navarro on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.

#import "TwitterAuthViewController.h"


@implementation TwitterAuthViewController
@synthesize request_url = _request_url;


-(void)httpRequestTicket:(OAServiceTicket *)ticket didFailWithError:(NSError *)error{

}

- (void)requestTokenTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data {
  if (ticket.didSucceed) {
    NSString *responseBody = [[[NSString alloc] initWithData:data
                                                   encoding:NSUTF8StringEncoding]autorelease];
    [TwitterAccessor sharedAccessor].request_token = [[OAToken alloc] initWithHTTPResponseBody:responseBody];
    [[TwitterAccessor sharedAccessor] saveRequestToken];
    
    self.request_url = [NSURL URLWithString:[NSString stringWithFormat:TWITTER_AUTHORIZE_URL,[TwitterAccessor sharedAccessor].request_token.key,TT_CALLBACK_URL]];
    
    NSURLRequest *request = [[[NSURLRequest alloc]initWithURL:self.request_url]autorelease];
    [webview_auth loadRequest:request];
  }
  else{
    [self.navigationController popViewControllerAnimated:YES];
    [self showErrorAlert];
  }
}

-(void)requestTokenTicket:(OAServiceTicket *)ticket didFailWithError:(NSError *)error{
  [self.navigationController popViewControllerAnimated:YES];
  [self showErrorAlert];  
}

#pragma mark - Web View Methods

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
  NSString *full_url = [[request URL] absoluteString];
  NSRange oauth_verifier = [full_url rangeOfString:@"oauth_verifier="];
  if(oauth_verifier.location != NSNotFound){
      
    NSRange oauth_token = [full_url rangeOfString:@"oauth_token="];
    NSString *token = [full_url  substringFromIndex:oauth_token.location+oauth_token.length];
    token =  [[token componentsSeparatedByString:@"&"] objectAtIndex:0];
    [[TwitterAccessor sharedAccessor].request_token setKey:token];
    [[TwitterAccessor sharedAccessor].request_token setVerifier:[full_url substringFromIndex:oauth_verifier.location+oauth_verifier.length]];
    [[TwitterAccessor sharedAccessor] saveRequestToken];
    [[TwitterAccessor sharedAccessor] requestAccessTokenWithDelegate:nil];
    
    [self dismissModalViewControllerAnimated:YES];
    return NO;
  }
  return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
  [self showErrorAlert];
}

-(void)showErrorAlert{
  UIAlertView *error_alert = [[UIAlertView alloc]initWithTitle:@"Twitter" message:@"It was not possible to login, try again later..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil,  nil];
  [error_alert show];
  [error_alert release];
}

#pragma mark - View lifecycle

- (id)init
{
  self = [super initWithNibName:@"TwitterAuthView" bundle:nil];
  if (self) {
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [[TwitterAccessor sharedAccessor] verifyCredentialsWithDelegate:self];
}


- (void)viewDidUnload
{
  self.request_url = nil;
  webview_auth = nil;
  [super viewDidUnload];
}

- (void)dealloc
{
  [_request_url release];
  [webview_auth release];
  [super dealloc];
}


@end
