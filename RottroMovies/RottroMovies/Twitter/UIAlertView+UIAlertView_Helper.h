//
//  UIAlertView+UIAlertView_Helper.h
//  SocialBOX
//
//  Created by Vitor Navarro on 10/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (UIAlertView_Helper)

+(void)showAlert:(NSDictionary *)alert withDelegate:(id)delegate;
@end
