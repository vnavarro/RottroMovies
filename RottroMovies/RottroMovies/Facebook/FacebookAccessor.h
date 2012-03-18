//
//  FacebookAccessor.h
//  SocialBOX
//
//  Created by Vitor Navarro on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"
#import "Constants.h"
#import "FBUser.h"
#import "FacebookParser.h"

@protocol FacebookLoginDelegate <NSObject>

-(void)onLogin;
-(void)onLoginError;

@end


@interface FacebookAccessor : NSObject <FBSessionDelegate,FBDialogDelegate,FBLoginDialogDelegate> {   
  NSArray* permissions;
}

@property (nonatomic,retain) Facebook *facebook;
@property (nonatomic, assign) id<FacebookLoginDelegate>delegate;

-(void)validateCredentials:(id<FacebookLoginDelegate>)delegate;
-(BOOL)isCredentialsValid;
-(BOOL)handleUrl:(NSURL *)url;
//Methods Requests
-(void)comment:(NSString *)comment andDelegate:(id<FBRequestDelegate>)delegate;
+(FacebookAccessor *) sharedAccessor;

@end
