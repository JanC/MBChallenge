//
// Created by Jan on 10/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBViewModel.h"

@class MBNote;
@class MBNoteDetailViewModel;

@interface MBNoteListViewModel : MBViewModel

@property(nonatomic, strong , readonly) NSFetchedResultsController *fetchedResultsController;
@property(nonatomic, strong, readonly) NSManagedObjectContext *model;

// Whether the view model is currently "active."
//
// This generally implies that the associated view is visible. When set to NO,
// the view model should throttle or cancel low-priority or UI-related work.
//
// This property defaults to NO.
@property (nonatomic, assign, readwrite, getter = isActive) BOOL active;

- (NSInteger)numberOfItems;
- (MBNote *) itemAtIndexPath:(NSIndexPath *) indexPath;
- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath;

-(MBNoteDetailViewModel *)detailViewModelForNewItem;
- (MBNoteDetailViewModel *)detailViewModelForIndexPath:(NSIndexPath *) indexPath;


@end