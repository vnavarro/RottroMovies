//
//  RTMovie.m
//  RottroMovies
//
//  Created by Vitor Navarro on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RTMovie.h"

@implementation RTMovie

@synthesize movieId=_movieId;
@synthesize title=_title;
@synthesize criticsRating=_criticsRating;
@synthesize mpaaRating=_mpaaRating;
@synthesize criticsScore=_criticsScore;
@synthesize year=_year;
@synthesize synopsis=_synopsis;
@synthesize runtime=_runtime;
@synthesize thumbnail=_thumbnail;
@synthesize original=_original;
@synthesize cast=_cast;
@synthesize movieLink=_movieLink;

- (void)dealloc
{
    [_movieId release];
    [_title release];
    [_year release];
    [_synopsis release];
    [_thumbnail release];
    [_original release];
    [_cast release];
    [_criticsRating release];
    [_mpaaRating release];
    [_movieLink release];
    [super dealloc];
}

@end
