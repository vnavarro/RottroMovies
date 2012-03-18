//
//  FacebookParser.m
//  SocialBOX
//
//  Created by Vitor Navarro on 7/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FacebookParser.h"


@implementation FacebookParser

+(FBUser *)parseUser:(NSDictionary *)json{
  if(json == nil) return nil;
  FBUser *user = [[[FBUser alloc]init]autorelease];
  user.user_id = [json objectForKey:@"id"];
  user.name = [json objectForKey:@"name"];
  NSLog(@"%@,%@",user.user_id,user.name);
  return user;
}
@end
