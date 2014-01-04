/* The MIT License (MIT)
Copyright (c) 19/10/2012 Sebastian Borggrewe

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#import "SBScrollNavigation.h"
#import <QuartzCore/QuartzCore.h>

@interface SBScrollNavigation()
  - (void) configure;
@end

@implementation SBScrollNavigation

// Measurements for inline padding of the ScrollNavigation
@synthesize horizontalPadding = _horizontalPadding;
@synthesize verticalPadding =  _verticalPadding;

// Button measurements
@synthesize btnHorizontalPadding = _btnHorizontalPadding;
@synthesize btnSpacing = _btnSpacing;
@synthesize btnCornerRadius = _btnCornerRadius;

// Selected Appearance
@synthesize btnColor = _btnColor;
@synthesize btnSelectedFontColor = _btnSelectedFontColor;
@synthesize btnShadowColor = _btnShadowColor;

// Normal and Standard appearance
@synthesize btnFont = _btnFont;
@synthesize btnFontColor = _btnFontColor;
@synthesize btnSelectedColor = _btnSelectedColor;

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

/* selectedIndex
 * returns the currently active index. Should not be
 * needed, but just in case.
 */
- (NSInteger) selectedIndex {
  return _selectedButton;
}

#pragma mark - Initialize and layout
/* initWithCoder:(NSCoder *)aDecoder
 *
 * In case the ScrollNavigation is initalized using 
 * storyboards.
 */
- (id) initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self configure];
  }
  
  return self;
}

/* initWithFrame:(CGRect)frame
 *
 * For initializing the ScrollNavigation
 * programatically.
 */
- (id) initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self configure];
  }
  
  return self;
}

/* configure
 *
 * Configuration of initial values. Gets called
 * when initalizing through initWithFrame and
 * initWithCoder. Values can be changed through setters.
 */
- (void) configure {
  
  // Configure UIScrollView
  self.showsHorizontalScrollIndicator = NO;
  self.canCancelContentTouches = YES;
  self.clipsToBounds = YES;
  self.backgroundColor = [UIColor blackColor];
  
  // Settings
  _btnHorizontalPadding = 10.0f;
  _horizontalPadding = 10.0f;
  _verticalPadding = 5.0f;
  _btnSpacing = 10.0f;
  
  // Button Appearance (State Independent)
  _btnCornerRadius = 5.0f;
  _btnFont = [UIFont boldSystemFontOfSize:15.0f];
  
  // Normal State Button Appearance
  _btnFontColor = [UIColor whiteColor];
  _btnColor = [UIColor clearColor];
  
  // Selected State Button Appearance
  _btnSelectedFontColor = [UIColor whiteColor];
  _btnSelectedColor = [UIColor redColor];
  _btnShadowColor = [UIColor darkGrayColor];
}


/* layoutSubviews
 * Layout the scrollView and set the selectedButton.
 */
- (void) layoutSubviews {
  
  // remove all buttons from superview, before adding the new ones
  [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
  
  // Initialize contenWidth
  int xPos = _horizontalPadding;
  
  // Get the number of menuItems from delegate
  if ([_menuDelegate respondsToSelector:@selector(numberOfMenuItems)]) {
    
    // Add the buttons
    for (int i=0; i<[_menuDelegate numberOfMenuItems]; i++) {
      
      // title buttons in navigation
      if ([_menuDelegate respondsToSelector:@selector(scrollView:titleForMenuIndex:)]) {
        
        // Get the title for the button
        NSString *menuItem = [_menuDelegate scrollView:self titleForMenuIndex:i];
        
        UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // Set Button Title
        [customButton setTitle:menuItem forState:UIControlStateNormal];
        
        // Change appearance
        customButton.titleLabel.font = _btnFont;
        customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        customButton.titleLabel.textColor = _btnFontColor;
        customButton.backgroundColor = _btnColor;
        
        customButton.clipsToBounds = YES;
        customButton.layer.cornerRadius = _btnCornerRadius;
        
        // tagged by ID to access it
        customButton.tag = i;
        
        // Add selector
        [customButton addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
        
        float buttonWidth = [menuItem sizeWithFont:customButton.titleLabel.font
                               constrainedToSize:CGSizeMake(9999, customButton.titleLabel.frame.size.height)
                                   lineBreakMode:NSLineBreakByClipping].width;
        
        customButton.frame = CGRectMake(xPos,                                         // current position in ScrollView
                                        _verticalPadding,                             // vertical ScrollView padding
                                        (buttonWidth + (2*_btnHorizontalPadding)),    // label size + horizontal btn padding
                                        self.frame.size.height-(2*_verticalPadding)); // vertical ScrollView padding
        
        // Add Btn to overall position
        xPos += customButton.frame.size.width + _btnSpacing;
        
        // Set the selected button style (shadow and color)
        if (_selectedButton == i) {
          customButton.backgroundColor = _btnSelectedColor;
          customButton.titleLabel.textColor = _btnSelectedFontColor;
          customButton.titleLabel.shadowColor = _btnShadowColor;
          customButton.titleLabel.shadowOffset = CGSizeMake(1, 1);
        }
        
        // Add to scrollView
        [self addSubview:customButton];
        
      // Views in case you don't want colored buttons
      } else if([_menuDelegate respondsToSelector:@selector(scrollView:viewForMenuIndex:)]) {
        // get view from delegate
        UIView *viewToAdd = [_menuDelegate scrollView:self viewForMenuIndex:i];
        
        // Create button surrounding view that has been added
        UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        customButton.clipsToBounds = YES;
        
        // Add selector
        [customButton addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
        
        customButton.frame = CGRectMake(xPos,
                                        _verticalPadding,
                                        viewToAdd.frame.size.width,
                                        self.frame.size.height-(2*_verticalPadding));
        
        // add view to button
        [customButton addSubview:viewToAdd];
        
        // add view size and spacing
        xPos += viewToAdd.frame.size.width+_btnSpacing;
        
        // add button to ScrollNavigation
        [self addSubview:customButton];
      }
      
      // Adjust overall size => remove btnSpacing
      // and add horizontal padding
      if (i == [_menuDelegate numberOfMenuItems]-1) {
        xPos += _horizontalPadding-_btnSpacing;
      }
    }
  }
  
  // Set overall contentSize
  self.contentSize = CGSizeMake(xPos,self.frame.size.height);
}

@end
