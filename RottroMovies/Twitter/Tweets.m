//
//  Tweets.m
//  SocialBOX
//
//  Created by Vitor Navarro on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Tweets.h"


@implementation Tweets
@synthesize tweet_id = _tweet_id;
@synthesize source= _source;
@synthesize date = _date;

- (id)init {
  self = [super init];
  if (self) {
    
  }
  return self;
}

- (void)dealloc {
  
  [_date release];
  [_source release];
  [_tweet_id release];
  [super dealloc];
}


@end
