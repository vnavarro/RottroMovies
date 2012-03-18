//
//  UIAlertView+UIAlertView_Helper.m
//  SocialBOX
//
//  Created by Vitor Navarro on 10/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UIAlertView+UIAlertView_Helper.h"


@implementation UIAlertView (UIAlertView_Helper)

+(void)showAlert:(NSDictionary *)alert withDelegate:(id<UIAlertViewDelegate>)delegate{
  UIAlertView *alert_view = [[[UIAlertView alloc]initWithTitle:[alert objectForKey:@"title"] 
                                                       message:[alert objectForKey:@"message"] 
                                                      delegate:delegate
                                             cancelButtonTitle:[alert objectForKey:@"cancel"] 
                                             otherButtonTitles:[alert objectForKey:@"ok"],  nil]autorelease];
  [alert_view show];
}

@end
