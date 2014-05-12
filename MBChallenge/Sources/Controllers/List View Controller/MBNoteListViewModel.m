//
// Created by Jan on 10/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "MBNoteListViewModel.h"
#import "MBNote.h"
#import "MBNoteDetailViewModel.h"
#import "NSManagedObjectContext+mainContext.h"
#import "MBNotesManager.h"

@interface MBNoteListViewModel () <NSFetchedResultsControllerDelegate>

@property(nonatomic, strong, readwrite) NSFetchedResultsController *fetchedResultsController;


@end

@implementation MBNoteListViewModel
{
}

#pragma mark
#pragma mark - Public

- (NSFetchedResultsController *)fetchedResultsController
{
    if ( _fetchedResultsController )
    {
        return _fetchedResultsController;
    }

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"MBNote"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO];

    fetchRequest.sortDescriptors = @[sortDescriptor];

    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                    managedObjectContext:self.model
                                                                      sectionNameKeyPath:nil cacheName:nil];

    _fetchedResultsController.delegate = self;

    return _fetchedResultsController;
}

- (NSInteger)numberOfItems
{
    id <NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[0];
    return sectionInfo.numberOfObjects;
}

- (MBNote *)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *moc = [NSManagedObjectContext currentContext];
    [moc deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
    [moc saveContext];
}

- (MBNoteDetailViewModel *)detailViewModelForIndexPath:(NSIndexPath *) indexPath
{
    MBNote *mbNote = [self.fetchedResultsController objectAtIndexPath:indexPath];
    MBNoteDetailViewModel *detailViewModel = [[MBNoteDetailViewModel alloc] initWithModel:mbNote];
    return detailViewModel;
}

- (MBNoteDetailViewModel *)detailViewModelForNewItem
{
    MBNote *mbNote = [NSEntityDescription insertNewObjectForEntityForName:@"MBNote" inManagedObjectContext:self.model];
    MBNoteDetailViewModel *detailViewModel = [[MBNoteDetailViewModel alloc] initWithModel:mbNote];
    detailViewModel.inserting = YES;
    return detailViewModel;
}

- (void)reload
{
    [super reload];

    self.loading = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.modelReloadBlock(self.isLoading, nil);
    });

    [[MBNotesManager sharedManager] importNotesWithCompletion:^{
        self.loading = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.modelReloadBlock(self.isLoading, nil);
        });
    }];
}


#pragma mark - Accessors

- (void)setActive:(BOOL)active
{
    _active = active;

    if(active)
    {
        [self.fetchedResultsController performFetch:nil];
    }
}

#pragma mark
#pragma mark - Protocols

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    if ( self.modelReloadBlock )
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.modelReloadBlock(self.isLoading, nil);
        });
    }
}


@end