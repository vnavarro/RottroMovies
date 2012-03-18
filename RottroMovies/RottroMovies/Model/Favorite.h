//
//  Favorite.h
//  RottroMovies
//
//  Created by Vitor Navarro on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Favorite : NSManagedObject

@property (nonatomic, retain) NSNumber * criticsScore;
@property (nonatomic, retain) NSString * movieLink;
@property (nonatomic, retain) NSString * thumbnail;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * movieId;

@end
