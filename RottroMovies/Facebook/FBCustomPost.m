//
//  FacebookPost.m
//  SocialBOX
//
//  Created by Vitor Navarro on 7/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FBCustomPost.h"


@implementation FBCustomPost

@synthesize description=_description;
@synthesize from_id=_from_id;
@synthesize from_name=_from_name;
@synthesize link=_link;
@synthesize message=_message;
@synthesize type=_type;
@synthesize post_id=_post_id;
@synthesize actions_link=_actions_link;
@synthesize actions_name=_actions_name;
@synthesize from_image_graph = _from_image_graph;
@synthesize likes=_likes;


-(void)addLike:(Like *)like{
  [self.likes addObject:like];
}

- (id)init {
  self = [super init];
  if (self) {
    self.likes = [NSMutableArray array];
  }
  return self;
}

- (void)dealloc {
  self.from_image_graph = nil;
  self.description = nil;
  self.from_name = nil;
  self.link = nil;
  self.message = nil;
  self.actions_link = nil;
  self.actions_name = nil;
  self.type = nil;
  self.post_id = nil;
  self.likes =nil;
  
  [_likes release];
  [_post_id release];
  [_from_image_graph release];
  [_description release];
  [_from_name release];
  [_link release];
  [_message release];
  [_type release];
  [_actions_link release];
  [_actions_name release];
  [super dealloc];
}


@end
