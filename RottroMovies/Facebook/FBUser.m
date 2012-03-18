//
//  FBUser.m
//  SocialBOX
//
//  Created by Vitor Navarro on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FBUser.h"

@implementation FBUser

@synthesize user_id =_user_id;
@synthesize name=_name;

- (void)dealloc {
  self.user_id = nil;
  self.name = nil;
  
  [_user_id release];
  [_name release];
  [super dealloc];
}

@end
