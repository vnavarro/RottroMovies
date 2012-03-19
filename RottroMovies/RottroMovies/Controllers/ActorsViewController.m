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
        self.position = position;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setFrame:CGRectMake(self.position.x, self.position.y, 280, 400)];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
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

@end
