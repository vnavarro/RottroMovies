//
//  MovieDetailsViewControllerViewController.h
//  RottroMovies
//
//  Created by Vitor Navarro on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTMovie.h"
#import "UIImageView+WebCache.h"
#import "LineViewController.h"
#import "ActorsViewController.h"
#import "SHKTwitter.h"
#import "FavoriteModel.h"

@interface MovieDetailsViewController : UIViewController

@property (strong,nonatomic) RTMovie *movie;
@property (retain, nonatomic) IBOutlet UIImageView *imgPoster;
@property (assign, nonatomic) IBOutlet UIScrollView *detailsScrollView;
@property (retain, nonatomic) IBOutlet UILabel *lblSynopsis;
@property (retain, nonatomic) IBOutlet UILabel *lblSynopsisTitle;
@property (retain, nonatomic) IBOutlet UILabel *lblCastTitle;
@property (retain, nonatomic) IBOutlet UILabel *lblFooter;
@property (retain, nonatomic) IBOutlet UIButton *btnFavorite;
- (IBAction)addToFavorites:(id)sender;

@property (strong,nonatomic) ActorsViewController *actorsTable;

-(id)initWithMovie:(RTMovie *)movie;

@end
