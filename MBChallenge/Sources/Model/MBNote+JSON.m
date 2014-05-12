//
// Created by Jan on 12/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "MBNote+JSON.h"

@implementation MBNote (JSON)

- (void)updateWithDict:(NSDictionary *)json
{
    self.text = (json[@"text"] && ![json[@"text"] isKindOfClass:[NSNull class]] ? json[@"text"] : @"" );
    self.uid = json[@"id"];
}
@end