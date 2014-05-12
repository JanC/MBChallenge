//
//  MBNote.m
//  MBChallenge
//
//  Created by Jan on 10/05/14.
//  Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "MBNote.h"

@implementation MBNote

@dynamic uid;
@dynamic text;
@dynamic creationDate;

+ (NSString *)entityName
{
    return NSStringFromClass([self class]);
}
@end
