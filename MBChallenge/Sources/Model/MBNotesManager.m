//
// Created by Jan on 12/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "MBNotesManager.h"
#import "MBNotesClient.h"
#import "NSManagedObjectContext+mainContext.h"
#import "MBNote.h"
#import "MBNote+JSON.h"

@interface MBNotesManager ()

@property (nonatomic, strong, readwrite) MBNotesClient *notesClient;
@property (nonatomic, copy, readwrite) MBNotesManagerCompletion importCompletion;

@end

@implementation MBNotesManager
{
}

- (id)init
{
    self = [super init];

    if ( self )
    {
        self.notesClient = [[MBNotesClient alloc] init];
    }

    return self;
}

#pragma mark
#pragma mark - Public

+ (instancetype)sharedManager
{
    static MBNotesManager *instance;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        instance = [[MBNotesManager alloc] init];
    });

    return instance;
}

- (void)importNotesWithCompletion:(MBNotesManagerCompletion)completion
{
    [self.notesClient fetchNotesWithCompletion:^(NSArray *noteDictionaries, NSError *error) {

        self.importCompletion = completion;
        [self insertOrUpdateNotes:noteDictionaries];
    }];
}

- (MBNote *)insertNewNote
{
    MBNote *mbNote = [NSEntityDescription insertNewObjectForEntityForName:[MBNote entityName] inManagedObjectContext:[NSManagedObjectContext currentContext]];

    mbNote.uid = [self nextUID];

    return mbNote;
}

#pragma mark
#pragma mark - Helpers

- (NSNumber *)nextUID
{
    __block NSNumber *nextUID = @0;

    NSManagedObjectContext *moc = [NSManagedObjectContext currentContext];

    [moc performBlockAndWait:^{
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[MBNote entityName]];
        fetchRequest.resultType = NSDictionaryResultType;
        fetchRequest.propertiesToFetch = @[ @"uid" ];

        NSError *error;
        NSArray *results = [moc executeFetchRequest:fetchRequest error:&error];

        if (results)
        {
            results = [results sortedArrayUsingDescriptors:@[ [NSSortDescriptor sortDescriptorWithKey:@"uid" ascending:YES] ]];
            NSDictionary *lastResult = [results lastObject];
            nextUID = @( MAX(0, [lastResult[@"uid"] doubleValue] + 1) );
        }

    }];

    return nextUID;
}

- (NSArray *)insertOrUpdateNotes:(NSArray *)jsonNotes
{
    NSManagedObjectContext *moc = [NSManagedObjectContext currentContext];

    [moc performBlock:^{

        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:[MBNote entityName] inManagedObjectContext:moc];

        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[MBNote entityName]];

        // fetch the model objects with the UID

        NSArray *dictUIDs = [jsonNotes valueForKey:@"id"];

        NSAssert(dictUIDs, @"We expect here the json dicts to have 'id' as keys");

        // predicate to search by uid
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid in %@", dictUIDs];
        fetchRequest.predicate = predicate;

        //
        // sort by uid both the local entities and the json ids
        //
        fetchRequest.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey:@"uid" ascending:YES] ];
        NSArray *sortedJsonNotes = [jsonNotes sortedArrayUsingComparator:^NSComparisonResult (id obj1, id obj2) {
                NSNumber *key1 = obj1[@"id"];
                NSNumber *key2 = obj2[@"id"];

                return [key1 compare:key2];
            }];

        NSError *error;
        NSArray *fetchResult = [moc executeFetchRequest:fetchRequest error:&error];

        if (error)
        {
            NSLog(@"fetch error %@", error);

            return;
        }

        //
        // loop over the json IDs. For existing local data, we do an update, for missing ones, we do an insert
        //
        NSEnumerator *modelEnumerator = [fetchResult objectEnumerator];
        __block MBNote *mbNote = [modelEnumerator nextObject];

        [sortedJsonNotes enumerateObjectsUsingBlock:^(NSDictionary *jsonDict, NSUInteger idx, BOOL *stop) {
                NSNumber *jsonUID = jsonDict[@"id"];
                NSNumber *localUID = mbNote.uid;

                if ( [jsonUID isEqual:localUID] )
                {
                    //
                    // Update the entity
                    //
                    [mbNote updateWithDict:jsonDict];

                    // next one
                    mbNote = [modelEnumerator nextObject];
                }
                else
                {
                    //
                    // Insert the entity
                    //
                    MBNote *note = (MBNote *)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:moc];
                    [note updateWithDict:jsonDict];
                }

                [moc saveContext];
            }];

        self.importCompletion();
    }];

    return nil;
}

@end