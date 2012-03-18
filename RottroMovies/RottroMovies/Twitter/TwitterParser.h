//
//  TwitterParser.h
//  SocialBOX
//
//  Created by Vitor Navarro on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tweets.h"
#import "SBJson.h"
#import "ASIHTTPRequest.h"
#import "ImageUtility.h"

@interface TwitterParser : NSObject {
    
}

+(NSArray *)getTweets:(NSString *)tweets_json;
+(NSArray *)getDMs:(NSString *)tweets_json;
@end
