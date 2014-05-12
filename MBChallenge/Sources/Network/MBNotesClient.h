//
// Created by Jan on 12/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MBNotesClientCompletion) (NSArray *noteDictionaries, NSError *error);


/**
 * Accesses the backed to fetch the notes. Here it is just a simulated version.
 * In a real app, this is the network layer.
 *
 */
@interface MBNotesClient : NSObject


/**
 *  There is a sleep inside to simulate the network loading
 *
 *  @param completion called upon completion
 */
- (void)fetchNotesWithCompletion:(MBNotesClientCompletion)completion;

@end