//
// Created by Jan on 12/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBNote.h"

@interface MBNote (JSON)

-(void)updateWithDict:(NSDictionary *)json;
@end