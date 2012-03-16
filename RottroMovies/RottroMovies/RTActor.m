//
//  RTActor.m
//  RottroMovies
//
//  Created by Vitor Navarro on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RTActor.h"

@implementation RTActor

@synthesize name=_name;
@synthesize roles=_roles;

- (void)dealloc
{
    [_name release];
    [_roles release];
    [super dealloc];
}

@end
