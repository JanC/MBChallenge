//
// Created by Jan Chaloupecky on 06/05/14.
// Copyright (c) 2014 Neofonie Mobile GmbH. All rights reserved.
//

#import "UIFont+MBStyle.h"

@implementation UIFont (MBStyle)

#pragma mark  
#pragma mark - Generic Fonts -

+ (UIFont *)helveticaNeueFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

+ (UIFont *)helveticaNeueMediumFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:size];
}

+ (UIFont *)helveticaNeueLightFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
}

+ (UIFont *)helveticaNeueUltraLightFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelvetiaNeue-UltraLight" size:size];
}

+ (UIFont *)helveticaNeueBoldFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}

+ (UIFont *)regularCorporateSFontWithSize:(CGFloat)size;
{
    return [UIFont fontWithName:@"CorporateS-Regular" size:size];
}

+ (UIFont *)boldCorporateSFontWithSize:(CGFloat)size;
{
    return [UIFont fontWithName:@"CorporateS-Bold" size:size];
}

+ (UIFont *)boldCorporateEFontWithSize:(CGFloat)size;
{
    return [UIFont fontWithName:@"CorporateE-Bold" size:size];
}

+ (UIFont *)dosisLightFontWithSize:(CGFloat)size;
{
    return [UIFont fontWithName:@"Dosis-Light" size:size];
}


+ (UIFont *)dosisMediumFontWithSize:(CGFloat)size;
{
    return [UIFont fontWithName:@"Dosis-Medium" size:size];
}

+ (UIFont *)dosisBoldFontWithSize:(CGFloat)size;
{
    return [UIFont fontWithName:@"Dosis-Bold" size:size];
}

#pragma mark  
#pragma mark - Fonts by use Case -

#pragma mark  
#pragma mark Bars

/// as used in
+ (UIFont *)MBNavigationBarFont
{
    return [UIFont dosisMediumFontWithSize:18.0f];
}

#pragma mark  

+ (UIFont *)MBNavigationTitleFont
{
    return [self helveticaNeueLightFontOfSize:25.0f];
}

+ (UIFont *)MBLightFontBig
{
    return [UIFont helveticaNeueUltraLightFontOfSize:60.0f];
}

#pragma mark - Toolbar
+ (UIFont *)MBToolbarTitleFont
{
    return [UIFont helveticaNeueMediumFontOfSize:15.0f];
}

#pragma mark  
#pragma mark Table View Cells

+ (UIFont *)MBGrayTableViewCellTitleFont;
{
    return [UIFont helveticaNeueFontOfSize:17.];
}

+ (UIFont *)MBGrayTableViewCellSubtitleFont;
{
    return [UIFont helveticaNeueBoldFontOfSize:17.];
}

+ (UIFont *)MBTableViewCellTitle
{
    return [self helveticaNeueLightFontOfSize:17.0f];
}

+ (UIFont *)MBGroupedTableHeaderTextFont
{
    return [self helveticaNeueMediumFontOfSize:17.0f];
}

+ (UIFont *)MBDefaultTextFont
{
    return [self dosisLightFontWithSize:17];
}

+ (UIFont *)MBDefaultSmallTextFont
{
    return [self regularCorporateSFontWithSize:15];
}

+ (UIFont *)MBDefaultBoldTextFont
{
    return [self boldCorporateSFontWithSize:17];
}
+ (UIFont *)MBDefaultBoldSmallTextFont
{
    return [self boldCorporateSFontWithSize:15];
}

@end
