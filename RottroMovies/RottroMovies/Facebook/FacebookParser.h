//
//  FacebookParser.h
//  SocialBOX
//
//  Created by Vitor Navarro on 7/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBUser.h"
#import "SBJson.h"

@interface FacebookParser : NSObject {
    
}

+(FBUser *)parseUser:(NSDictionary *)json;

@end
