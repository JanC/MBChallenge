//
// Created by Jan on 10/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "NSManagedObjectContext+mainContext.h"
#import "MBAppDelegate.h"

@implementation NSManagedObjectContext (mainContext)

+ (NSManagedObjectContext *)mainContext
{
    MBAppDelegate *appDel = (MBAppDelegate *)[[UIApplication sharedApplication] delegate];

    return appDel.managedObjectContext;
}

+ (NSManagedObjectContext *)backgroundContext
{
    static NSManagedObjectContext *BackgroundContext;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        BackgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [BackgroundContext setParentContext:[self mainContext]];
    });

    return BackgroundContext;
}

+ (NSManagedObjectContext *)currentContext
{
    if ( [[NSThread currentThread] isMainThread] )
        return [self mainContext];

    return [self backgroundContext];
}

- (void)saveContext
{
    if ( ![self hasChanges] )
        return;

    NSError *error = nil;

    if ( ![self save:&error] )
    {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

}

#pragma mark - Query Helper methods

@end
