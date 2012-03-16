//
//  Contants.h
//  RottroMovies
//
//  Created by Vitor Navarro on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#define RT_KEY @"svbq8zvh527r2pemyfkfz37j"
#define RT_TOPTEN_URL @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=svbq8zvh527r2pemyfkfz37j&limit=10"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]