/* This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.

   Created by Sebastian Borggrewe on 19/10/2012
*/

#import <UIKit/UIKit.h>

@class SBScrollNavigation;

@protocol SBScrollNavigationDelegate <NSObject>

// gets the number of menu items (needs to be implemented)
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
  
  // Selected Index
  NSInteger _selectedButton;
  
  // Measurements for inline padding of the ScrollNavigation
  float _horizontalPadding;
  float _verticalPadding;
  
  // Button measurements
  float _btnHorizontalPadding;
  float _btnSpacing;
  float _btnCornerRadius;
  
  // Selected Appearance
  UIColor *_btnColor;
  UIColor *_btnSelectedFontColor;
  UIColor *_btnShadowColor;
  
  // Normal and Standard appearance
  UIFont *_btnFont;
  UIColor *_btnFontColor;
  UIColor *_btnSelectedColor;
  
  // delegate for ScrollNavigation. UIScrollView delegate can
  // still be used.
  __weak id <SBScrollNavigationDelegate> _menuDelegate;
}

@property (nonatomic, weak) IBOutlet id <SBScrollNavigationDelegate> menuDelegate;

@property (nonatomic) float horizontalPadding;
@property (nonatomic) float verticalPadding;

@property (nonatomic) float btnHorizontalPadding;
@property (nonatomic) float btnSpacing;
@property (nonatomic) float btnCornerRadius;

@property (nonatomic, strong) UIColor *btnColor;
@property (nonatomic, strong) UIColor *btnSelectedFontColor;
@property (nonatomic, strong) UIColor *btnShadowColor;


@property (nonatomic, strong) UIFont *btnFont;
@property (nonatomic, strong) UIColor *btnFontColor;
@property (nonatomic, strong) UIColor *btnSelectedColor;

- (void) selectedButton:(id)sender;
- (void) setSelectedIndex:(NSInteger)index;

@end
