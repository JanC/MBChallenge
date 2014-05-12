//
// Created by Jan on 10/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBTableViewCell.h"

@class MBNote;

@interface MBTableViewCell (MBNote)

- (void)configureForMBNote:(MBNote *)mbNote;
@end