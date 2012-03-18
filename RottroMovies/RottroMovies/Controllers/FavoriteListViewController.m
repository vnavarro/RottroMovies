//
//  FavoriteListViewController.m
//  RottroMovies
//
//  Created by Vitor Navarro on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoriteListViewController.h"

@interface FavoriteListViewController ()

@end

@implementation FavoriteListViewController
@synthesize fav_cell_temp=_fav_cell_temp;

- (id)init
{
    self = [super init];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:0];
        [self setTitle:@"Favorites"];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{    
    [super viewWillAppear:animated];
    [self downloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cell_nib = [UINib nibWithNibName:@"FavoriteCellView" bundle:nil];    

    
    [self setTitle:@"Favorites"];
}

- (void)dealloc
{
    [_fav_cell_temp release];
    [super dealloc];
}

#pragma mark - Data Fetch

-(void)refresh{
    self.data = [Favorite findAllSortedBy:@"title" ascending:YES];
    [self.tableView reloadData];
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:0.5];
}

#pragma mark - UITableView

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{  
    Favorite *movie = [self.data objectAtIndex:indexPath.row];
    [(FavoriteCellController*)cell layoutWithFavorite:movie];
    
    if(indexPath.row%2){
        [cell setBackgroundColor:[UIColor whiteColor]];
    }else {
        [cell setBackgroundColor:UIColorFromRGB(0xF2F2F2)];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"cell";
    
    FavoriteCellController *cell = (FavoriteCellController *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        [self.cell_nib instantiateWithOwner:self options:nil];
        cell = self.fav_cell_temp;
        self.cell_temp = nil;
    }
    [cell setDelegate:self];
     
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma  mark - FavoriteCellDelegate
-(void)updateFavorites{
    [self refresh];
}

@end
