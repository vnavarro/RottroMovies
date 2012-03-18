//
//  FavoriteCellController.h
//  RottroMovies
//
//  Created by Vitor Navarro on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorite.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"

@protocol FavoriteCellDelegate <NSObject>

-(void)updateFavorites;

@end

@interface FavoriteCellController : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *imgPoster;
@property (retain, nonatomic) IBOutlet UILabel *lblTitle;
@property (retain, nonatomic) IBOutlet UIImageView *imgRating;
@property (retain, nonatomic) IBOutlet UILabel *lblRating;
@property (retain, nonatomic) IBOutlet UIButton *btnUnfavorite;
@property (retain, nonatomic) Favorite *movie;
@property (assign, nonatomic) id<FavoriteCellDelegate> delegate;

- (IBAction)unfavorite:(id)sender;
-(void)layoutWithFavorite:(Favorite *)movie;

@end
