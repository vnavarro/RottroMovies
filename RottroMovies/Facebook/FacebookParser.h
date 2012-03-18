//
//  FacebookParser.h
//  SocialBOX
//
//  Created by Vitor Navarro on 7/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBCustomPost.h"
#import "Like.h"
#import "FBUser.h"
#import "SBJson.h"

@interface FacebookParser : NSObject {
    
}

+(NSArray *)parsePosts:(NSDictionary *)json;
+(FBUser *)parseUser:(NSDictionary *)json;

@end
