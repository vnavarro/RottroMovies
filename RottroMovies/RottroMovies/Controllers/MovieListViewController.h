//
//  MovieListViewController.h
//  RottroMovies
//
//  Created by Vitor Navarro on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieCellController.h"
#import "PullRefreshTableViewController.h"
#import "RottenTomatoesInterface.h"
#import "Constants.h"
#import "MovieDetailsViewController.h"

@interface MovieListViewController : PullRefreshTableViewController <UITableViewDelegate,
UITableViewDataSource,RottenTomatoesDelegate>

@property (strong,nonatomic) IBOutlet UINib *cell_nib;
@property (strong,nonatomic) IBOutlet MovieCellController *cell_temp;

@property (strong,nonatomic) NSArray *data;

-(void)downloadData;
@end
