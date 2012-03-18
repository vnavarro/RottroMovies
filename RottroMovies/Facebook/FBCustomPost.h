//
//  FacebookPost.h
//  SocialBOX
//
//  Created by Vitor Navarro on 7/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonPost.h"
#import "Like.h"

@interface FBCustomPost : CommonPost {
    
}

@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *from_id;
@property (nonatomic, retain) NSString *post_id;
@property (nonatomic, retain) NSString *from_name;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *actions_link;
@property (nonatomic, retain) NSString *actions_name;
@property (nonatomic, retain) NSURL *from_image_graph;
@property (nonatomic, retain) NSMutableArray *likes;

-(void)addLike:(Like *)like;
@end
