//
// Created by Jan on 10/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBTableViewCell : UITableViewCell

@property (nonatomic, strong, readonly) UILabel *noteCreationDateLabel;
@property (nonatomic, strong, readonly) UILabel *noteTitleLabel;
@property (nonatomic, strong, readonly) UITextField *noteTextField;

@end