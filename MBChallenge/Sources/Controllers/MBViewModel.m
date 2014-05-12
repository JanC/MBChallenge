//
// Created by Jan on 10/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "MBViewModel.h"

@interface MBViewModel ()
@property (nonatomic, strong, readwrite) id model;
@property(nonatomic, copy, readwrite) MBViewModelReloadCallbackBlock modelReloadBlock;


@end

@implementation MBViewModel
{
}

- (id)initWithModel:(id)model
{
    self = [super init];
    if ( self )
    {
        self.model = model;
    }
    return self;
}

- (id)initWithModel:(id)model reloadCallbackBlock:(MBViewModelReloadCallbackBlock)modelReloadCallback
{
    self = [super init];
    if ( self )
    {
        self.model = model;
        self.modelReloadBlock = modelReloadCallback;

    }
    return self;
}

- (void)reload
{

}

@end