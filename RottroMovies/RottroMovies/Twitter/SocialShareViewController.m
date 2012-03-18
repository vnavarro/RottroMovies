//
//  TwitterViewController.m
//  SocialBOX
//
//  Created by Vitor Navarro on 8/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SocialShareViewController.h"

@implementation SocialShareViewController



#pragma mark - Actions
@synthesize lblShareSize;
@synthesize txtStatus;
@synthesize status=_status;
@synthesize isTwitter=_isTwitter;

- (void)updateStatus{
    if(self.isTwitter){
        NSInteger actual_count = 140-[self.txtStatus.text length];
        if(actual_count >= 0) [[TwitterAccessor sharedAccessor] doUpdate:self.txtStatus.text];
    }else {
        [SVProgressHUD showInView:self.view];
        [[FacebookAccessor sharedAccessor] comment:self.txtStatus.text andDelegate:self]; 
    }
}

#pragma mark - Facebook Delegate

-(void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response{
    [SVProgressHUD dismissWithSuccess:@"Shared succefully"];
    [self.txtStatus resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    [SVProgressHUD dismissWithError:[error localizedDescription]];
    [self.txtStatus resignFirstResponder];
}

#pragma mark - TextView Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
  
}

- (void)textViewDidEndEditing:(UITextView *)textView{
  
}

- (void)textViewDidChange:(UITextView *)textView{
  if(self.isTwitter) [self updateTextSize:self.txtStatus];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
  if ([text isEqualToString:@"\n"]) {
    [textView resignFirstResponder];
    return FALSE;
  }
  return TRUE;
}

#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
  [textField resignFirstResponder];
  [self.txtStatus becomeFirstResponder];
  return TRUE;
}


-(void)updateTextSize:(UITextView *)textView{
    NSInteger actual_count = 140-[textView.text length];
    [self.lblShareSize setText:[NSString stringWithFormat:@"%d",actual_count]];
    if(actual_count < 0)
        [self.lblShareSize setTextColor:[UIColor redColor]];
    else
        [self.lblShareSize setTextColor:[UIColor blackColor]];    
}


#pragma mark - View lifecycle

-(id)initWithStatus:(NSString *)status{
  self = [super init];
  if(self){
      self.status = status;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
    [self.txtStatus setText:self.status];
    if (self.isTwitter) {
        [self updateTextSize:self.txtStatus];
    }else{
        [self.lblShareSize setHidden:YES];
    }
    
    UIBarButtonItem *right_button = [[UIBarButtonItem alloc]initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(update)];
    
    [self.navigationItem setRightBarButtonItem:right_button];
}

- (void)viewDidUnload
{

    [self setLblShareSize:nil];
    [self setTxtStatus:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {

    [_status release];
    [lblShareSize release];
    [txtStatus release];
  [super dealloc];
}

@end
