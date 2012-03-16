//
//  RottroMoviesTests.m
//  RottroMoviesTests
//
//  Created by Vitor Navarro on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RottenTomatoesInterfaceTests.h"

@implementation RottenTomatoesInterfaceTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

-(void)testGetTopTenBoxOffice{
  NSDictionary *topTen = [[RottenTomatoesInterface shared]getTopTenBoxOffice];
  NSArray *result = [topTen objectForKey:@"movies"];
  STAssertTrue([result count]>0,@"Didnt get top ten box office");
}

-(void)testGetMovieFromJson{
    NSDictionary *jsonObject = [MOVIE_JSON JSONValue];
    RTMovie *movie = [[RottenTomatoesInterface shared]getMovieFromJson:jsonObject];    
    STAssertNotNil(movie,@"It should be a movie here not nil");
}

-(void)testGetNilMovieFromJson{
    NSDictionary *jsonObject = [NSDictionary dictionary];
    RTMovie *movie = [[RottenTomatoesInterface shared]getMovieFromJson:jsonObject];    
    STAssertNil(movie,@"It should be nil");
}

-(void)testGetMoviesFromJson{
    NSArray *movies = [[RottenTomatoesInterface shared]getMoviesFromJson:[MOVIES_JSON JSONValue]];
    STAssertTrue([movies count]== 1,@"The movie wasnt parse right");
}


@end
