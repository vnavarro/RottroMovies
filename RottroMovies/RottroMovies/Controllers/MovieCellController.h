//
//  MovieCellControllerCell.h
//  RottroMovies
//
//  Created by Vitor Navarro on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTMovie.h"
#import "UIImageView+WebCache.h"

@interface MovieCellController : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *imgCover;
@property (retain, nonatomic) IBOutlet UILabel *lblTitle;
@property (retain, nonatomic) IBOutlet UIProgressView *pgRating;
@property (retain, nonatomic) IBOutlet UIImageView *imgMPAARating;

-(void)layoutWithMovie:(RTMovie *)movie;

@end
