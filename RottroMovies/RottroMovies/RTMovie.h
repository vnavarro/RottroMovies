//
//  RTMovie.h
//  RottroMovies
//
//  Created by Vitor Navarro on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum MPAA{
    G,
    NC17,
    PG13,
    PG,
    R
}MPAA;

@interface RTMovie : NSObject

@property (strong,nonatomic) NSString *movieId;
@property (strong,nonatomic) NSString *title;
@property (assign,nonatomic) MPAA mpaaRating;
@property (strong,nonatomic) NSString *criticsRating;
@property (assign,nonatomic) NSInteger criticsScore;
@property (strong,nonatomic) NSString *year;
@property (strong,nonatomic) NSString *synopsis;
@property (assign,nonatomic) NSInteger *fresh;
@property (assign,nonatomic) NSInteger runtime;
@property (strong,nonatomic) NSURL *thumbnail;
@property (strong,nonatomic) NSURL *original;
@property (strong,nonatomic) NSArray *cast;


-(void)setMPAARatingWithString:(NSString *)mpaa;

@end
