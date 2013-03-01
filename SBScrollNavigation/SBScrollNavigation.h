//
//  UIWeScrollNavigation.h
//  Stadtmagazin
//
//  Created by Sebastian Borggrewe on 19/10/2012.
//  Copyright (c) 2012 Stadtmagazin GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBScrollNavigation;

@protocol SBScrollNavigationDelegate <NSObject>

- (NSInteger) numberOfMenuItems;

@optional
// either use a view for your menu items
- (UIView *) scrollView:(SBScrollNavigation *)scrollView viewForMenuIndex:(NSInteger) index;

// Or use a button
- (NSString *) scrollView:(SBScrollNavigation *)scrollView titleForMenuIndex:(NSInteger) index;

// Get notified, when a menu Item is selected
- (void) scrollView:(SBScrollNavigation *)scrollView menuItemSelectedAtIndex:(NSInteger) index;

@end


@interface SBScrollNavigation : UIScrollView {
  NSArray *_items;
  NSInteger _selectedButton;
  NSInteger _leftRightPadding;
  NSInteger _buttonPadding;
  NSInteger _topPadding;
  NSInteger _btnWidthAdjustment;
  NSInteger _btnCornerRadius;
  
  UIColor *_btnFontColor;
  UIColor *_btnSelectedFontColor;
  
  UIColor *_btnShadowColor;
  
  UIFont *_btnFont;
  
  UIColor *_btnColor;
  UIColor *_btnSelectedColor;
  BOOL _hasShadow;
  
  __weak id <SBScrollNavigationDelegate> _menuDelegate;
}

@property (nonatomic, weak) IBOutlet id <SBScrollNavigationDelegate> menuDelegate;

- (void) selectedButton:(id)sender;
- (void) setSelectedIndex:(NSInteger)index;

@end
