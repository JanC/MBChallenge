//
// Created by Jan on 10/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "MBTableViewCell+MBNote.h"
#import "MBNote.h"

@implementation MBTableViewCell (MBNote)

- (void)configureForMBNote:(MBNote *)mbNote
{
    #warning dummy
    self.noteTitleLabel.text = mbNote.text;
}
@end