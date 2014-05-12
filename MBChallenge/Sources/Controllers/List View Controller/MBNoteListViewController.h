//
// Created by Jan on 10/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBNoteListViewModel;

@interface MBNoteListViewController : UIViewController

@property (nonatomic, strong, readonly) MBNoteListViewModel *viewModel;

@end