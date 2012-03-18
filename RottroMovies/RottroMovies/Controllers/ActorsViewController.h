//
//  ActorsViewController.h
//  RottroMovies
//
//  Created by Vitor Navarro on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTActor.h"
#import "UIImageView+WebCache.h"

@interface ActorsViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) NSArray *data;
@property (assign,nonatomic) CGPoint position;

-(id)initWithData:(NSArray *)actors andPosition:(CGPoint)position;

@end
