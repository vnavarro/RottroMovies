//
//  NSMutableArray+Helper.m
//  SocialBOX
//
//  Created by Vitor Navarro on 8/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSMutableArray+Helper.h"

@implementation NSMutableArray (NSMutableArray_Helper)


-(void)addNewTweetsFromArray:(NSArray *)array{
  if (!self || [self count] == 0) {
    [self addObjectsFromArray:array];
  }
  else{
    NSMutableArray *to_add = [[[NSMutableArray alloc]init]autorelease];
    BOOL found;
    for (Tweets *tweet in array) {
      found = NO;
      for (int i=0; i<[self count]; i++) {
        CommonPost *object = [self objectAtIndex:i];
        if(object.post_type == TweetPostType && [tweet.tweet_id isEqual:((Tweets *)object).tweet_id]){
          found=YES;
          break;
        }
      }
      if(!found) [to_add addObject:tweet];
    }
    [self addObjectsFromArray:to_add];
  }
}

-(void)addNewInstaFromArray:(NSArray *)array{
  if (!self || [self count] == 0) {
    [self addObjectsFromArray:array];
  }
  else{
    NSMutableArray *to_add = [[[NSMutableArray alloc]init]autorelease];
    BOOL found;
    for (InstagramPost *insta in array) {
      found = NO;
      for (int i=0; i<[self count]; i++) {
        CommonPost *object = [self objectAtIndex:i];
        if(object.post_type == InstagramPostType && [insta.img_url isEqual:((InstagramPost *)object).img_url]){
          found=YES;
          break;
        }
      }
      if(!found) [to_add addObject:insta];
    }
    [self addObjectsFromArray:to_add];
  }
}

//TODO:Checar metodo do fb
-(void)addNewFbNewsFromArray:(NSArray *)array{
  if (!self || [self count] == 0) {
    [self addObjectsFromArray:array];
  }
  else{
    NSMutableArray *to_add = [[[NSMutableArray alloc]init]autorelease];
    BOOL found;
    for (FBCustomPost *fbnews in array) {
      found = NO;
      for (int i=0; i<[self count]; i++) {
        CommonPost *object = [self objectAtIndex:i];
        if(object.post_type == FbPostType && [fbnews.actions_link isEqual:((FBCustomPost *)object).actions_link]){
          found=YES;
          break;
        }
      }
      if(!found) [to_add addObject:fbnews];
    }
    [self addObjectsFromArray:to_add];
  }
}


@end
