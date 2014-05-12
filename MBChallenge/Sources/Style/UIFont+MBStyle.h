//  Created by Jan on 10/05/14.
//  Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (MBStyle)

#pragma mark - Navigation Bar

+ (UIFont *)MBNavigationBarFont;

+ (UIFont *)MBNavigationTitleFont;

+ (UIFont *)MBLightFontBig;

#pragma mark - Toolbar

+ (UIFont *)MBToolbarTitleFont;

#pragma mark - Table View Cells

+ (UIFont *)MBGrayTableViewCellTitleFont;

+ (UIFont *)MBGrayTableViewCellSubtitleFont;

+ (UIFont *)MBTableViewCellTitle;



#pragma mark - Shared fonts
+ (UIFont *)MBDefaultTextFont;
+ (UIFont *)MBDefaultSmallTextFont;
+ (UIFont *)MBDefaultBoldTextFont;
+ (UIFont *)MBDefaultBoldSmallTextFont;

#pragma mark  
#pragma mark - TableView Cells -

#pragma mark  
#pragma mark - TableView Headers -

+ (UIFont *)MBGroupedTableHeaderTextFont;

@end
