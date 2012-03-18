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
#import "FavoriteModel.h"
#import "TwitterAccessor.h"
#import "TwitterAuthViewController.h"
#import "SocialShareViewController.h"
#import "FacebookAccessor.h"

@interface MovieDetailsViewController : UIViewController <FacebookLoginDelegate>

@property (strong,nonatomic) RTMovie *movie;
@property (retain, nonatomic) IBOutlet UIImageView *imgPoster;
@property (assign, nonatomic) IBOutlet UIScrollView *detailsScrollView;
@property (retain, nonatomic) IBOutlet UILabel *lblSynopsis;
@property (retain, nonatomic) IBOutlet UILabel *lblSynopsisTitle;
@property (retain, nonatomic) IBOutlet UILabel *lblCastTitle;
@property (retain, nonatomic) IBOutlet UILabel *lblFooter;
@property (retain, nonatomic) IBOutlet UIButton *btnFavorite;
@property (retain, nonatomic) IBOutlet UIButton *btnFacebook;
@property (strong,nonatomic) ActorsViewController *actorsTable;

- (IBAction)addToFavorites:(id)sender;
- (IBAction)shareFacebook:(id)sender;
-(id)initWithMovie:(RTMovie *)movie;

@end
