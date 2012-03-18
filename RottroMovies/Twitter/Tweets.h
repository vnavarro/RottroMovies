//
//  Tweets.h
//  SocialBOX
//
//  Created by Vitor Navarro on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonPost.h"

@interface Tweets : CommonPost {
    
}

@property (nonatomic,retain) NSString *tweet_id;
@property (nonatomic,retain) NSString *source;
@property (nonatomic,retain) NSDate *date;


@end
