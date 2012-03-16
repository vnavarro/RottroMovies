//
//  MovieCellControllerCell.m
//  RottroMovies
//
//  Created by Vitor Navarro on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MovieCellController.h"

@implementation MovieCellController
@synthesize imgCover;
@synthesize lblTitle;
@synthesize pgRating;
@synthesize imgMPAARating;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

-(void)layoutWithMovie:(RTMovie *)movie{
    [self.lblTitle setText:movie.title];
    switch (movie.mpaaRating) {
        case G:
            [self.imgMPAARating setImage:[UIImage imageNamed:@"g.png"]];
            break;
        case NC17:
            [self.imgMPAARating setImage:[UIImage imageNamed:@"nc_17.png"]];
            break;
        case PG13:
            [self.imgMPAARating setImage:[UIImage imageNamed:@"pg_13.png"]];
            break;
        case PG:
            [self.imgMPAARating setImage:[UIImage imageNamed:@"pg.png"]];
            break;
        case R:
            [self.imgMPAARating setImage:[UIImage imageNamed:@"r.png"]];
            break;
    }
    [self.imgCover setImageWithURL:movie.thumbnail];
    [self.pgRating setProgress:movie.criticsScore/100.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [imgCover release];
  [lblTitle release];
  [pgRating release];
  [imgMPAARating release];
    [super dealloc];
}
@end
