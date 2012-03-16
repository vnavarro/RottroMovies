//
//  RottenTomatoesInterface.m
//  RottroMovies
//
//  Created by Vitor Navarro on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RottenTomatoesInterface.h"

@implementation RottenTomatoesInterface
@synthesize delegate=_delegate;

-(void)getTopTenBoxOffice:(id<RottenTomatoesDelegate>)delegate{
  NSURL *requestUrl = [NSURL URLWithString:RT_TOPTEN_URL];
  ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:requestUrl];
  [request setDelegate:self];
  [self setDelegate:delegate];
  [request startAsynchronous];
}

-(NSDictionary *)getTopTenBoxOffice{
  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:RT_TOPTEN_URL]];
  NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
  NSString *responseValue = [[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding] autorelease];
  return [responseValue JSONValue];
}

-(RTMovie *)getMovieFromJson:(NSDictionary *)jsonValue{
    if(jsonValue && [jsonValue count] > 0){
        RTMovie *movie = [[[RTMovie alloc]init]autorelease];
        movie.movieId = [jsonValue objectForKey:@"id"];
        movie.title = [jsonValue objectForKey:@"title"];
        [movie setMPAARatingWithString:[jsonValue objectForKey:@"mpaa_rating"]];
        
        NSDictionary *ratings = [jsonValue objectForKey:@"ratings"];
        movie.criticsScore = [[ratings objectForKey:@"critics_score"] intValue];
        movie.criticsRating = [ratings objectForKey:@"critics_rating"]; 
        movie.synopsis = [jsonValue objectForKey:@"critics_rating"];         
        
        NSDictionary *posters = [jsonValue objectForKey:@"posters"];
        movie.thumbnail = [NSURL URLWithString:[posters objectForKey:@"thumbnail"]];         
        movie.original = [NSURL URLWithString:[posters objectForKey:@"original"]]; 
        
        NSArray *cast = [jsonValue objectForKey:@"abridged_cast"];
        NSMutableArray *movieCast = [NSMutableArray arrayWithCapacity:[cast count]];
        for (NSDictionary *actor in cast) {
            RTActor *movieActor = [[[RTActor alloc]init]autorelease];
            movieActor.name = [actor objectForKey:@"name"];
            movieActor.roles = [actor objectForKey:@"characters"];
            [movieCast addObject:movieActor];
        }
        movie.cast = movieCast;
        movie.runtime = [[jsonValue objectForKey:@"runtime"] intValue];
        movie.year = [jsonValue objectForKey:@"year"];
        
        return movie;
    }
    return nil;
}

-(NSArray *)getMoviesFromJson:(NSDictionary *)jsonValue{
    if(jsonValue && [jsonValue count] > 0){    
        NSArray *moviesJson = [jsonValue objectForKey:@"movies"];
        NSMutableArray *movies = [NSMutableArray array];
        for (NSDictionary *movie in moviesJson) {
            RTMovie *newMovie = [[RottenTomatoesInterface shared] getMovieFromJson:movie];
            if(newMovie) [movies addObject:newMovie];
        }
        return movies;
    }
    return nil;
}

#pragma mark - ASIHTTPDelegate

- (void)requestFinished:(ASIHTTPRequest *)request
{
  NSDictionary *movies = [[request responseString] JSONValue];
  [self.delegate getTopTenBoxOffice:[[RottenTomatoesInterface shared] getMoviesFromJson:movies]];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
  //NSError *error = [request error];
  UIAlertView *message = [[UIAlertView alloc]initWithTitle:@"Something went wrong!" message:@"Please check your internet connection." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
  [message show];
}


#pragma mark - Lifecycle

static RottenTomatoesInterface *shared_instance;

+(RottenTomatoesInterface *) shared {
  
  @synchronized(self) {
    if (!shared_instance)
			shared_instance = [[RottenTomatoesInterface alloc] init];
  }
  return shared_instance;
}

- (id)init {
  self = [super init];
  if (self) {
  }
  return self;
}

-(void)dealloc{
  [super dealloc];
}

@end
