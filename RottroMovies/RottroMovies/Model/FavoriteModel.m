//
//  Favorite+Favorite.m
//  RottroMovies
//
//  Created by Vitor Navarro on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoriteModel.h"

@implementation Favorite (Model)
+(BOOL)addFavoriteFromMovie:(RTMovie *)movie{
    if(![Favorite findFirstByAttribute:@"movieId" withValue:movie.movieId]){
        Favorite *newFavorite = [Favorite createEntity];
        newFavorite.title = movie.title;
        newFavorite.thumbnail = [movie.thumbnail absoluteString];
        NSLog(@"%@ %d",[NSNumber numberWithInteger:movie.criticsScore],movie.criticsScore);
        newFavorite.criticsScore = [NSNumber numberWithInteger:movie.criticsScore];
        NSLog(@"%@",newFavorite.criticsScore);
        newFavorite.movieLink = movie.movieLink;
        newFavorite.movieId = movie.movieId;   
        
        [[NSManagedObjectContext defaultContext] save];
        
        return true;
    }
    return false;
}
@end
