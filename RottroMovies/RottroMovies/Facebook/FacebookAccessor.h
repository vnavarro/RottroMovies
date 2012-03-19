//
//  FacebookAccessor.h
//  RottroMovies
//
//  Created by Vitor Navarro on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"
#import "Constants.h"

@protocol FacebookLoginDelegate <NSObject>

-(void)onFbAccessorLogin;
-(void)onFbAccessorLoginError;

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
