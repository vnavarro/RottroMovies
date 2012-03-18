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
#import "Like.h"
#import "FBUser.h"
#import "FacebookParser.h"



@interface FacebookAccessor : NSObject <FBSessionDelegate,FBDialogDelegate,FBLoginDialogDelegate,FBRequestDelegate> {   
  NSArray* permissions;
}

@property (nonatomic,retain) Facebook *facebook;
@property (nonatomic, retain) FBUser *me;

-(void)validateCredentials;
-(BOOL)isCredentialsValid;
-(BOOL)handleUrl:(NSURL *)url;
-(void)loadMeUser;
-(BOOL)didILikeApost:(NSMutableArray *)likes;
//Methods Requests
-(void)getPosts:(id<FBRequestDelegate>)delegate;
-(void)getImageFromUser:(NSString *)user_id withDelegate:(id<FBRequestDelegate>)delegate;
-(void)likePost:(NSString *)post_id withDelegate:(id<FBRequestDelegate>)delegate;
-(void)unlikePost:(NSString *)post_id;
-(void)getMeWithParams:(NSMutableDictionary *)params andDelegate:(id<FBRequestDelegate>)delegate;
-(void)comment:(NSString *)comment inPost:(NSString *)status_id andDelegate:(id<FBRequestDelegate>)delegate;
+(FacebookAccessor *) sharedAccessor;

@end
