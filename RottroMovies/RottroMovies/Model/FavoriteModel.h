//
//  Favorite+Favorite.h
//  RottroMovies
//
//  Created by Vitor Navarro on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Favorite.h"
#import "RTMovie.h"

@interface Favorite (Model)
+(BOOL)addFavoriteFromMovie:(RTMovie *)movie;
@end
