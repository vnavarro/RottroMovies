//
//  RTMovie.h
//  RottroMovies
//
//  Created by Vitor Navarro on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTMovie : NSObject

@property (strong,nonatomic) NSString *movieId;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *mpaaRating;
@property (strong,nonatomic) NSString *criticsRating;
@property (assign,nonatomic) NSInteger criticsScore;
@property (strong,nonatomic) NSString *year;
@property (strong,nonatomic) NSString *synopsis;
@property (assign,nonatomic) NSInteger runtime;
@property (strong,nonatomic) NSURL *thumbnail;
@property (strong,nonatomic) NSURL *original;
@property (strong,nonatomic) NSArray *cast;
@property (strong,nonatomic) NSString *movieLink;


//-(void)setMPAARatingWithString:(NSString *)mpaa;

@end
