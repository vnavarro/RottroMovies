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
@synthesize fresh=_fresh;
@synthesize runtime=_runtime;
@synthesize thumbnail=_thumbnail;
@synthesize original=_original;
@synthesize cast=_cast;

-(void)setMPAARatingWithString:(NSString *)mpaa{
    NSString *lowerCaseMpaa = [mpaa lowercaseString];
    if([lowerCaseMpaa isEqualToString:@"pg"]){
        self.mpaaRating = PG;
    }else if([lowerCaseMpaa isEqualToString:@"pg-13"]){
        self.mpaaRating = PG13;
    }else if ([lowerCaseMpaa isEqualToString:@"r"]) {
        self.mpaaRating = R;
    }else if ([lowerCaseMpaa isEqualToString:@"nc-17"]) {
        self.mpaaRating = NC17;
    }else if ([lowerCaseMpaa isEqualToString:@"g"]) {
        self.mpaaRating = G;
    }
}

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
    [super dealloc];
}

@end
