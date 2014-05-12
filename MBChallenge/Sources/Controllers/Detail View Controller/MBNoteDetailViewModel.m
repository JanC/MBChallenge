//
// Created by Jan on 10/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "MBNoteDetailViewModel.h"
#import "MBNote.h"

@implementation MBNoteDetailViewModel
{
}

#pragma mark - Public

- (void)cancel
{
    if ( self.inserting )
    {
        [self.model.managedObjectContext deleteObject:self.model];
    }
}
- (void)willDismiss
{
    [self.model.managedObjectContext save:nil];
}

- (BOOL)shouldShowCancelButton
{
    return self.inserting;
}
@end