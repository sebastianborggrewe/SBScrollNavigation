//
//  UIWeScrollNavigation.m
//  Stadtmagazin
//
//  Created by Sebastian Borggrewe on 19/10/2012.
//  Copyright (c) 2012 Stadtmagazin GmbH. All rights reserved.
//

#import "SBScrollNavigation.h"
#import <QuartzCore/QuartzCore.h>

@interface SBScrollNavigation()
  - (void) configure;
@end

@implementation SBScrollNavigation

@synthesize menuDelegate = _menuDelegate;

#pragma mark - Custom Methods

/* selectedButton:(id)sender
 *
 * The method is being triggered once a menu item
 * is selected. It's passing the call onto the delegate
 */
- (void) selectedButton:(id)sender {
  NSInteger index = ((UIButton *)sender).tag;
  _selectedButton = index;
  [self setNeedsLayout];
  if ([_menuDelegate respondsToSelector:@selector(scrollView:menuItemSelectedAtIndex:)]) {
    [_menuDelegate scrollView:self menuItemSelectedAtIndex:index];
  }
}

/* setSelectedIndex:(NSInteger)index
 *
 * Method to set the selected button. Can
 * be called to programatically set the selected
 * button.
 */
- (void) setSelectedIndex:(NSInteger)index {
  _selectedButton = index;
  UIView *button = [self viewWithTag:index];
  [self scrollRectToVisible:button.frame animated:YES];
}

#pragma mark - Initialize and layout
- (id) initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self configure];
  }
  
  return self;
}

- (id) initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self configure];
  }
  
  return self;
}

- (void) configure {
  NSLog(@"INIT");
  
  // Configure UIScrollView
  self.showsHorizontalScrollIndicator = NO;
  self.backgroundColor = [UIColor blackColor];
  
  // Settings
  _buttonPadding = 25;
  _leftRightPadding = 10;
  _topPadding = 5;
  _btnWidthAdjustment = 30;
  
  // Button Appearance (State Independent)
  _btnCornerRadius = 5.0f;
  _btnFont = [UIFont boldSystemFontOfSize:15];
  
  // Normal State Button Appearance
  _btnFontColor = [UIColor whiteColor];
  _btnColor = [UIColor clearColor];
  
  // Selected State Button Appearance
  _btnSelectedFontColor = [UIColor whiteColor];
  _btnSelectedColor = [UIColor redColor];
  _btnShadowColor = [UIColor darkGrayColor];
}


/* layoutSubviews
 * Layout the scrollView
 */
- (void) layoutSubviews {
  
  // remove all buttons from superview, before adding the new ones
  [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
  
  // Initialize contenWidth
  CGFloat contentWidth = 0.0;
  int xPos = _leftRightPadding;
  
  // Get the number of menuItems from delegate
  if ([_menuDelegate respondsToSelector:@selector(numberOfMenuItems)]) {
  
    NSString *menuItem;
    
    // Add the buttons
    for (int i=0; i<[_menuDelegate numberOfMenuItems]; i++) {
      
      // title buttons in navigation
      if ([_menuDelegate respondsToSelector:@selector(scrollView:titleForMenuIndex:)]) {
        
        // Get the title for the button
        menuItem = [_menuDelegate scrollView:self titleForMenuIndex:i];
        
        contentWidth += [menuItem sizeWithFont:_btnFont].width + _btnWidthAdjustment;
        
        UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [customButton setTitle:menuItem forState:UIControlStateNormal];
        customButton.titleLabel.font = _btnFont;
        customButton.titleLabel.textColor = _btnFontColor;
        customButton.backgroundColor = _btnColor;
        
        //customButton.clipsToBounds = YES;
        customButton.layer.cornerRadius = _btnCornerRadius;
        
        // tagged by ID to access it
        customButton.tag = i;
        
        [customButton addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];

        int buttonWidth = [menuItem sizeWithFont:customButton.titleLabel.font
                               constrainedToSize:CGSizeMake(150, self.frame.size.height-(2*_topPadding))
                                   lineBreakMode:NSLineBreakByClipping].width;
        
        customButton.frame = CGRectMake(xPos,
                                        _topPadding,
                                        (buttonWidth + _buttonPadding),
                                        self.frame.size.height-(2*_topPadding));
        NSLog(@"Custom Frame: %@",NSStringFromCGRect(customButton.frame));
        
        xPos += buttonWidth;
        
        if (_selectedButton == i) {
          
          customButton.backgroundColor = _btnSelectedColor;
          
          customButton.titleLabel.shadowColor = _btnShadowColor;
          customButton.titleLabel.shadowOffset = CGSizeMake(1, 1);

        }
        
        [self addSubview:customButton];
        
      // Views in case you don't want buttons
      } else if([_menuDelegate respondsToSelector:@selector(scrollView:viewForMenuIndex:)]) {
        UIView *viewToAdd = [_menuDelegate scrollView:self viewForMenuIndex:i];
        
        xPos += viewToAdd.frame.size.width;
        
        [self addSubview:viewToAdd];
      }
      
      // Padding
      if (i < [_menuDelegate numberOfMenuItems]-1) {
        xPos += _buttonPadding;
      } else {
        xPos += _buttonPadding+_leftRightPadding;
      }
      
    }
  }
  
  self.contentSize = CGSizeMake(xPos,self.frame.size.height);
}

@end
