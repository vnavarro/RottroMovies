//
//  ActorsViewController.m
//  RottroMovies
//
//  Created by Vitor Navarro on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActorsViewController.h"

@interface ActorsViewController ()

@end

@implementation ActorsViewController

@synthesize data=_data;
@synthesize position=_position;

-(id)initWithData:(NSArray *)actors andPosition:(CGPoint)position{
    self = [super init];
    if(self){
        self.data = [NSArray arrayWithArray:actors];
        NSLog(@"%@",self.data);
        self.position = position;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self setView:self.tableView];
    
    //[self.tableView setDelegate:self];
    //[self.tableView setDataSource:self];
    
    [self.tableView setFrame:CGRectMake(self.position.x, self.position.y, 280, 400)];//[self.data count]*80)];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    /*[self.tableView setFrame:CGRectMake(self.position.x, self.position.y, 280, [self.data count]*[self.tableView rowHeight])];*/
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [_data release];
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
            NSLog(@"%@",self.data);
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell){
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"]autorelease];
    }
    
    
    RTActor *actor = [self.data objectAtIndex:[indexPath row]];
    cell.textLabel.text = actor.name;
    //cell.detailTextLabel.text = @"testing first";
    [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];    
    [cell.imageView setImage:[UIImage imageNamed:@"Perfil User-03.png"]];
    [cell.imageView setFrame:CGRectMake(cell.imageView.frame.origin.x, cell.imageView.frame.origin.y, 64, 64)];
    
    NSString *roles = @"%@%@";
    
    for (NSString *role in actor.roles) {  
        roles = [NSString stringWithFormat:roles,role,@", %@%@"];
    }
    [cell.detailTextLabel setText:[roles stringByReplacingOccurrencesOfString:@", %@%@" withString:@""]];
    
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
