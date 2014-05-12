//
//  UIColor+MBStyle.m
//  Apotheke-iPad
//
//  Created by Fabian Fett on 4/1/14.
//  Copyright (c) 2014 Neofonie Mobile GmbH. All rights reserved.
//

#import "UIColor+MBStyle.h"
#import "HexColor.h"


@implementation UIColor (MBStyle)



#pragma mark  
#pragma mark - Default Colors -

+ (UIColor *)MBPinkColor
{
    return [UIColor colorWithHexString:@"#D55D5C"];

}


#pragma mark  
#pragma mark Text Colors
+ (UIColor *)MBDefaultTextColor
{
    return [UIColor colorWithHexString:@"#464947"];

}
+ (UIColor *)MBLightTextGrayColor
{
    return [UIColor colorWithHexString:@"#8E8E93"];
}

+ (UIColor *)MBLinkTextColor
{
    return [UIColor colorWithHexString:@"#2666B5"];
}


@end
