//
//  LineView.m
//  RottroMovies
//
//  Created by Vitor Navarro on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LineViewController.h"

@implementation LineViewController

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, 0, 0, 0, 1);
    CGContextSetLineCap(ctx,kCGLineCapRound);
    CGContextSetLineWidth(ctx, self.frame.size.height-20);
    CGContextMoveToPoint(ctx, 10, self.frame.size.height/2);
    CGContextAddLineToPoint(ctx, self.frame.size.width-10, self.frame.size.height/2);
    CGContextStrokePath(ctx);
}


@end
