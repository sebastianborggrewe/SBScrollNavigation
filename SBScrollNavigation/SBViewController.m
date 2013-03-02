//
//  SBViewController.m
//  SBScrollNavigation
//
//  Created by Sebastian Borggrewe on 3/1/13.
//  Copyright (c) 2013 Sebastian Borggrewe. All rights reserved.
//

#import "SBViewController.h"

@interface SBViewController ()

@end

@implementation SBViewController

@synthesize scrollNavigation;
@synthesize myLabel;

#pragma mark - SBScrollNavigation 

- (NSInteger) numberOfMenuItems {
  return [_items count];
}

// either use a view for your menu items
/*- (UIView *) scrollView:(SBScrollNavigation *)scrollView viewForMenuIndex:(NSInteger) index {
  
}*/

// Or use a button (DON'T USE BOTH)
- (NSString *) scrollView:(SBScrollNavigation *)scrollView titleForMenuIndex:(NSInteger) index {
  return [NSString stringWithFormat:@"Button %d",index];
}

// Get notified, when a menu Item is selected
- (void) scrollView:(SBScrollNavigation *)scrollView menuItemSelectedAtIndex:(NSInteger) index {
  
  // example: altering some values once button has been clicked
  [myLabel setText:[NSString stringWithFormat:@"(%d) %@",index,[_items objectAtIndex:index]]];
}


#pragma mark - View Cycle
- (void)viewDidLoad
{
  [super viewDidLoad];
	
  // Part of the example: defining data for buttons to trigger
  _items = [NSArray arrayWithObjects:@"This is just an example",@"of what you can do",@"with this library.",@"Enjoy and please,",@"let me know,",@"if you have any difficulties ",@"or",@"if you enjoy using it :)",@"Sebastian", nil];
  
  // setting default label data
  [myLabel setText:[NSString stringWithFormat:@"(0) %@",[_items objectAtIndex:0]]];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
