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

#pragma mark - SBScrollNavigation 

- (NSInteger) numberOfMenuItems {
  return 8;
}

// either use a view for your menu items
/*- (UIView *) scrollView:(SBScrollNavigation *)scrollView viewForMenuIndex:(NSInteger) index {
  
}*/

// Or use a button (DON'T USE BOTH)
- (NSString *) scrollView:(SBScrollNavigation *)scrollView titleForMenuIndex:(NSInteger) index {
  NSLog(@"Button %d",index);
  
  return [NSString stringWithFormat:@"Button %d",index];
}

// Get notified, when a menu Item is selected
- (void) scrollView:(SBScrollNavigation *)scrollView menuItemSelectedAtIndex:(NSInteger) index {
  NSLog(@"Selected Button %d",index);
}


#pragma mark - View Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
