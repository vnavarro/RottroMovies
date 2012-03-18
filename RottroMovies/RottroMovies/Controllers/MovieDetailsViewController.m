//
//  MovieDetailsViewControllerViewController.m
//  RottroMovies
//
//  Created by Vitor Navarro on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MovieDetailsViewController.h"

@interface MovieDetailsViewController ()

@end

@implementation MovieDetailsViewController
@synthesize movie =_movie;
@synthesize imgPoster = _imgPoster;
@synthesize detailsScrollView = _detailsScrollView;
@synthesize lblSynopsis = _lblSynopsis;
@synthesize lblSynopsisTitle = _lblSynopsisTitle;
@synthesize lblCastTitle = _lblCastTitle;
@synthesize lblFooter = _lblFooter;
@synthesize btnFavorite = _btnFavorite;
@synthesize actorsTable = _actorsTable;

-(id)initWithMovie:(RTMovie *)movie{
    self = [super init];
    if (self) {
        [self setMovie:movie];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:self.movie.title];
    [self.imgPoster setImageWithURL:self.movie.original placeholderImage:[UIImage imageNamed:@"loading.png"]];
    
    CGSize synopsisSize = [self.movie.synopsis sizeWithFont:self.lblSynopsis.font constrainedToSize:CGSizeMake(280, 9999) lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect frame = self.lblSynopsis.frame;
    frame.size = synopsisSize;
    [self.lblSynopsis setFrame:frame];
    [self.lblSynopsis setText:self.movie.synopsis];
    
    frame = self.lblCastTitle.frame;
    frame.origin.y = self.lblSynopsis.frame.origin.y + self.lblSynopsis.frame.size.height + 20;
    [self.lblCastTitle setFrame:frame];
    
    self.actorsTable = [[ActorsViewController alloc]initWithData:self.movie.cast andPosition:CGPointMake(20, 300)];
    frame = self.actorsTable.view.frame;
    frame.origin.y = self.lblCastTitle.frame.origin.y + self.lblCastTitle.frame.size.height+ 20;
    [self.actorsTable.view setFrame:frame];
    [self.view addSubview:self.actorsTable.view];        
    
    LineViewController *line = [[[LineViewController alloc]initWithFrame:CGRectMake(0, 20, 320, 25)]autorelease];
    frame = line.frame;
    frame.origin.y = self.lblCastTitle.frame.origin.y + 270;
    [line setFrame:frame];
    [self.view addSubview:line];
    
    frame = self.lblFooter.frame;
    frame.origin.y = line.frame.origin.y + line.frame.size.height;
    [self.lblFooter setFrame:frame];
    
    NSString *footerText = self.lblFooter.text;
    [self.lblFooter setText:[NSString stringWithFormat:footerText,self.movie.mpaaRating,self.movie.criticsScore,self.movie.runtime/60,self.movie.runtime%60]];    
    
    [self.detailsScrollView setScrollEnabled:YES];
    [self.detailsScrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.lblFooter.frame.origin.y+self.lblFooter.frame.size.height)];    
    
    UIImage *tweetImg =  [UIImage imageNamed:@"Twitter.png"];
    CGFloat imgWidth = tweetImg.size.width*.8f;
    
    UIButton *btn = [[UIButton buttonWithType:UIButtonTypeCustom]retain];
    [btn setImage:tweetImg forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tweet:) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(0, 0, imgWidth,imgWidth )];
    
    
    UIBarButtonItem *right_button = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    [self.navigationItem setRightBarButtonItem:right_button];
}

-(void)tweet:(id)sender{
   [SHKTwitter shareText:[NSString stringWithFormat:@"I liked a movie %@ #Flixter #RottroMovies",self.movie.movieLink]];
}

- (void)viewDidUnload
{
    [self setImgPoster:nil];
    [self setLblSynopsis:nil];
    [self setLblSynopsisTitle:nil];
    [self setLblCastTitle:nil];
    [self setLblFooter:nil];
    [self setBtnFavorite:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [_movie release];
    [_imgPoster release];
    [_lblSynopsis release];
    [_lblSynopsisTitle release];
    [_lblCastTitle release];
    [_lblFooter release];
    [_actorsTable release];
    [_btnFavorite release];
    [super dealloc];
}

- (IBAction)addToFavorites:(id)sender {
    [Favorite addFavoriteFromMovie:self.movie];
}
@end
