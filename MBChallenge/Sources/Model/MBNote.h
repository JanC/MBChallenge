//
//  MBNote.h
//  MBChallenge
//
//  Created by Jan on 10/05/14.
//  Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MBNote : NSManagedObject

#pragma mark
#pragma mark - Generates properties

@property (nonatomic, retain) NSNumber * uid;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * creationDate;


#pragma mark
#pragma mark - Custom stuff

+(NSString *) entityName;





@end
