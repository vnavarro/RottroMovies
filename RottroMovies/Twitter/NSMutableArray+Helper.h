//
//  NSMutableArray+Helper.h
//  SocialBOX
//
//  Created by Vitor Navarro on 8/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tweets.h"
#import "InstagramPost.h"
#import "FBCustomPost.h"

@interface NSMutableArray (NSMutableArray_Helper)

-(void)addNewTweetsFromArray:(NSArray *)array;
-(void)addNewInstaFromArray:(NSArray *)array;
//TODO:Checar metodo do fb
-(void)addNewFbNewsFromArray:(NSArray *)array;
@end
