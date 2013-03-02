//
//  SBViewController.h
//  SBScrollNavigation
//
//  Created by Sebastian Borggrewe on 3/1/13.
//  Copyright (c) 2013 Sebastian Borggrewe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBScrollNavigation.h"

@interface SBViewController : UIViewController <SBScrollNavigationDelegate> {
  NSArray *_items;
}


@property (nonatomic, strong) IBOutlet SBScrollNavigation *scrollNavigation;
@property (nonatomic, strong) IBOutlet UILabel *myLabel;

@end
