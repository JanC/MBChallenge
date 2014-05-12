//
// Created by Jan on 10/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBViewModel.h"

@class MBNote;

@interface MBNoteDetailViewModel : MBViewModel

@property (nonatomic, strong, readonly) MBNote *model;

@property (nonatomic, assign, readwrite) BOOL inserting;

-(void)cancel;
-(void)willDismiss;
-(BOOL)shouldShowCancelButton;

@end