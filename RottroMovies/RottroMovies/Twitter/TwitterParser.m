//
//  TwitterParser.m
//  SocialBOX
//
//  Created by Vitor Navarro on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterParser.h"


@implementation TwitterParser

+(NSArray *)getTweets:(NSString *)tweets_json{
  NSArray *to_parse_tweets = [tweets_json JSONValue];
  
  NSMutableArray *tweets = [NSMutableArray array];
  
  for (NSDictionary *tweet_info in to_parse_tweets) {
    NSLog(@"%@",tweet_info);
    Tweets *tweet = [[[Tweets alloc]init]autorelease];
    tweet.post_type = TweetPostType;
    tweet.text = [tweet_info objectForKey:@"text"];
    tweet.source = [tweet_info objectForKey:@"source"];
    tweet.tweet_id = [tweet_info objectForKey:@"id_str"];
    //tweet.date = [tweet_info objectForKey:@"created_at"]; TODO: Formatar a data
    NSDictionary *user = [tweet_info objectForKey:@"user"];
    tweet.name = [user objectForKey:@"screen_name"];
    tweet.avatar_url = [user objectForKey:@"profile_image_url"];
    [tweets addObject:tweet];
  }
  return tweets;
}

+(NSArray *)getDMs:(NSString *)tweets_json{
  NSArray *to_parse_tweets = [tweets_json JSONValue];
  
  NSMutableArray *tweets = [NSMutableArray array];
  
  for (NSDictionary *tweet_info in to_parse_tweets) {
    NSLog(@"%@",tweet_info);
    Tweets *tweet = [[[Tweets alloc]init]autorelease];
    tweet.post_type = TweetPostType;
    tweet.text = [tweet_info objectForKey:@"text"];
    
    tweet_info = [tweet_info objectForKey:@"sender"];
    tweet.source = [tweet_info objectForKey:@"source"];
    tweet.tweet_id = [tweet_info objectForKey:@"id"];
    //tweet.date = [tweet_info objectForKey:@"created_at"]; TODO: Formatar a data
    tweet.name = [tweet_info objectForKey:@"screen_name"];
    tweet.avatar_url = [tweet_info objectForKey:@"profile_image_url"];
    [tweets addObject:tweet];
  }
  return tweets;
}

@end
