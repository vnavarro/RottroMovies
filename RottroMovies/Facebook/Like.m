//
//  FbLikes.m
//  SocialBOX
//
//  Created by Vitor Navarro on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Like.h"

@implementation Like

@synthesize user_id=_user_id;
@synthesize name=_name;

- (void)dealloc {
  self.user_id = nil;
  self.name = nil;
  
  [_user_id release];
  [_name release];
  
  [super dealloc];
}

@end
