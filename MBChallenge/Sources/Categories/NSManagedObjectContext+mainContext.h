//
// Created by Jan on 10/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface NSManagedObjectContext (mainContext)

+ (NSManagedObjectContext *)mainContext;
+ (NSManagedObjectContext *)backgroundContext;
+ (NSManagedObjectContext *)currentContext;

- (void)saveContext;



@end
