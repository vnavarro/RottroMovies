//
//  FavoriteListViewController.h
//  RottroMovies
//
//  Created by Vitor Navarro on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieListViewController.h"
#import "Favorite.h"
#import "FavoriteCellController.h"

@interface FavoriteListViewController : MovieListViewController <FavoriteCellDelegate>

@property (strong,nonatomic) IBOutlet FavoriteCellController *fav_cell_temp;

@end
