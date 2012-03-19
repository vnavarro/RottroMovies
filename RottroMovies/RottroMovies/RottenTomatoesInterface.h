//
//  RottenTomatoesInterface.h
//  RottroMovies
//
//  Created by Vitor Navarro on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "NSString+SBJSON.h"
#import "Constants.h"
#import "RTMovie.h"
#import "RTActor.h"

@protocol RottenTomatoesDelegate <NSObject>

-(void)getTopTenBoxOffice:(NSArray *)results;
-(void)requestFailed;
@end

@interface RottenTomatoesInterface : NSObject

@property (assign,nonatomic) id<RottenTomatoesDelegate> delegate;

-(void)getTopTenBoxOffice:(id<RottenTomatoesDelegate>)delegate;
-(RTMovie *)getMovieFromJson:(NSDictionary *)jsonValue;
-(NSArray *)getMoviesFromJson:(NSDictionary *)jsonValue;
-(NSDictionary *)getTopTenBoxOffice;
+(RottenTomatoesInterface *) shared;

@end
