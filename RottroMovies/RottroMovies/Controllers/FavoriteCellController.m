//
//  FavoriteCellController.m
//  RottroMovies
//
//  Created by Vitor Navarro on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoriteCellController.h"

@implementation FavoriteCellController
@synthesize imgPoster;
@synthesize lblTitle;
@synthesize imgRating;
@synthesize lblRating;
@synthesize btnUnfavorite;
@synthesize movie=_movie;
@synthesize delegate=_delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [super setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];
}

-(void)layoutWithFavorite:(Favorite *)movie{
    [self.lblTitle setText:movie.title];
    if([movie.criticsScore intValue] >= 60){
        [self.imgRating setImage:[UIImage imageNamed:@"Fresh.png"]];
    }
    else{
        [self.imgRating setImage:[UIImage imageNamed:@"Rotten.png"]]; 
    }
    [self.lblRating setText:[NSString stringWithFormat:@"%@%%",movie.criticsScore]];
    [self.lblRating setTextColor:UIColorFromRGB(0x506A16)];
    
    [self.imgPoster setImageWithURL:[NSURL URLWithString:movie.thumbnail] placeholderImage:[UIImage imageNamed:@"loading.png"]];
    
    [self setMovie:movie];
}

- (void)dealloc {
    [imgPoster release];
    [lblTitle release];
    [imgRating release];
    [lblRating release];
    [btnUnfavorite release];
    [_movie release];
    [super dealloc];
}
- (IBAction)unfavorite:(id)sender {
    if(self.movie){
        [self.movie deleteEntity];
    }
    [self.delegate updateFavorites];
}
@end
