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

+(NSArray *)parsePosts:(NSDictionary *)json{
  NSDictionary *data_posts = [json objectForKey:@"data"];
  
  //NSLog(@"%@",data_posts);
  
  NSMutableArray *fb_posts = [NSMutableArray array];
  
  for (NSDictionary *fb_post in data_posts) {
    NSLog(@"%@",fb_post);
    FBCustomPost *post = [[[FBCustomPost alloc]init]autorelease];
    post.description = [fb_post objectForKey:@"description"];
    post.link = [fb_post objectForKey:@"link"];    
    post.name = [fb_post objectForKey:@"name"];
    post.post_id = [fb_post objectForKey:@"id"];
    
    post.message = [fb_post objectForKey:@"message"];
    post.text = post.message;
    if(!post.text || [post.text isEqualToString:@""])
      post.text = post.name;
    
    post.type = [fb_post objectForKey:@"type"];
    
    NSDictionary *from = [fb_post objectForKey:@"from"];
    
    NSLog(@"%@",[from objectForKey:@"id"]);
    post.from_id = [from objectForKey:@"id"];
    post.from_name = [from objectForKey:@"name"];
    NSLog(@"%@",post.from_id);
    
    NSArray *actions = [fb_post objectForKey:@"actions"];
    for (NSDictionary *action in actions) {
      post.actions_link = [action objectForKey:@"link"];
      post.actions_name = [action objectForKey:@"name"];
    }
    
    NSDictionary *likes_object =[fb_post objectForKey:@"likes"];
    NSLog(@"%@",likes_object);
    NSArray *likes = [likes_object objectForKey:@"data"];
        NSLog(@"%@",likes);
    for(NSDictionary *like in likes){
              NSLog(@"%@",like);
      Like *new_like = [[[Like alloc]init]autorelease];
      new_like.user_id = [like objectForKey:@"id"];
      new_like.name = [like objectForKey:@"name"];
      [post addLike:new_like];
    }
    
    post.post_type = FbPostType;
    post.avatar_url = [CommonPost fbFromImageUrl:post.from_id];
    
    [fb_posts addObject:post];
  }
  
  return fb_posts;
}
@end
