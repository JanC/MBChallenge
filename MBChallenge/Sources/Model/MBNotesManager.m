//
// Created by Jan on 12/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "MBNotesManager.h"
#import "MBNotesClient.h"

@interface MBNotesManager()

@property (nonatomic, strong, readwrite) MBNotesClient *notesClient;

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
        if(completion)
        {
            completion();
        }
    }];
}
@end