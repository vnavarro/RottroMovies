//
//  MovieListViewController.m
//  RottroMovies
//
//  Created by Vitor Navarro on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MovieListViewController.h"

@interface MovieListViewController ()

@end

@implementation MovieListViewController
@synthesize cell_nib =_cell_nib;
@synthesize cell_temp = _cell_temp;
@synthesize data=_data;

- (id)init
{
    self = [super init];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:0];
        [self setTitle:@"Top Box Office"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cell_nib = [UINib nibWithNibName:@"MovieCellView" bundle:nil];    
  
    [self.tableView setRowHeight:110];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self downloadData];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{
  [_data release];
  [_cell_nib release];
  [_cell_temp release];
  [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Data Fetch

-(void)downloadData{
  [self startLoading];
}

-(void)getTopTenBoxOffice:(NSArray *)results{
    self.data = results;
    [self.tableView reloadData];
    [self stopLoading];
}

-(void)requestFailed{
    [self stopLoading];
}

-(void)refresh{
  [[RottenTomatoesInterface shared]getTopTenBoxOffice:self];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{      
    RTMovie *movie = [self.data objectAtIndex:indexPath.row];
    MovieCellController *movieCell = (MovieCellController *)cell;
    [movieCell layoutWithMovie:movie];
    
    if(indexPath.row%2){
        [cell setBackgroundColor:[UIColor whiteColor]];
    }else {
        [cell setBackgroundColor:UIColorFromRGB(0xF2F2F2)];
    }
    
    CGSize titleSize = [movieCell.lblTitle.text sizeWithFont:movieCell.lblTitle.font];
    CGRect imgFrame = movieCell.imgMPAARating.frame;    
    float newX = movieCell.lblTitle.frame.origin.x+titleSize.width+5;    
    imgFrame.origin.x = (newX > imgFrame.origin.x) ? imgFrame.origin.x : newX;
    
    [movieCell.imgMPAARating setFrame:imgFrame];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"cell";
  
    MovieCellController *cell = (MovieCellController *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
    if (cell == nil){
      [self.cell_nib instantiateWithOwner:self options:nil];
      cell = self.cell_temp;
      self.cell_temp = nil;
    }
  
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieDetailsViewController *movieDetails = [[[MovieDetailsViewController alloc]initWithMovie:[self.data objectAtIndex:indexPath.row]]autorelease];
    [self.navigationController pushViewController:movieDetails animated:YES];
}

@end
