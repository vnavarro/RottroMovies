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
@synthesize isFavorite;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

-(void)layoutWithMovie:(RTMovie *)movie{
    [self.lblTitle setText:movie.title];
    NSString *lowerCaseMpaa = [movie.mpaaRating lowercaseString];
    if([lowerCaseMpaa isEqualToString:@"pg"]){
        [self.imgMPAARating setImage:[UIImage imageNamed:@"pg.png"]];
    }else if([lowerCaseMpaa isEqualToString:@"pg-13"]){
        [self.imgMPAARating setImage:[UIImage imageNamed:@"pg_13.png"]];
    }else if ([lowerCaseMpaa isEqualToString:@"r"]) {
        [self.imgMPAARating setImage:[UIImage imageNamed:@"r.png"]];
    }else if ([lowerCaseMpaa isEqualToString:@"nc-17"]) {
        [self.imgMPAARating setImage:[UIImage imageNamed:@"nc_17.png"]];
    }else if ([lowerCaseMpaa isEqualToString:@"g"]) {
        [self.imgMPAARating setImage:[UIImage imageNamed:@"g.png"]];
    }
    [self.imgCover setImageWithURL:movie.thumbnail placeholderImage:[UIImage imageNamed:@"loading.png"]];
    [self.pgRating setProgress:movie.criticsScore/100.0f];
}

- (void)dealloc {
    [imgCover release];
  [lblTitle release];
  [pgRating release];
  [imgMPAARating release];
    [super dealloc];
}
@end
