//
// Created by Jan on 12/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^MBNotesManagerCompletion) ();

/**
 *  Responsible for fetching, inserting and updating the notes that come from the backend
 *
 */
@interface MBNotesManager : NSObject

+ (instancetype)sharedManager;

- (void)importNotesWithCompletion:(MBNotesManagerCompletion)completion;

@end