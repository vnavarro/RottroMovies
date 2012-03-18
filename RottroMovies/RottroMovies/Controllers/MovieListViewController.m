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
    [(MovieCellController*)cell layoutWithMovie:movie];
    
    if(indexPath.row%2){
        [cell setBackgroundColor:[UIColor whiteColor]];
    }else {
        //[UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1]
        [cell setBackgroundColor:UIColorFromRGB(0xF2F2F2)];
    }
    
    MovieCellController *movieCell = (MovieCellController *)cell;
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieDetailsViewController *movieDetails = [[[MovieDetailsViewController alloc]initWithMovie:[self.data objectAtIndex:indexPath.row]]autorelease];
    [self.navigationController pushViewController:movieDetails animated:YES];
}

@end
