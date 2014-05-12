//
// Created by Jan on 10/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^MBViewModelReloadCallbackBlock)(BOOL loading, NSString *loadingMessage);


@interface MBViewModel : NSObject

// The model which the view model is adapting for the UI.
@property (nonatomic, strong, readonly) id model;

@property (nonatomic, assign, getter = isLoading) BOOL loading;

@property(nonatomic, copy, readonly) MBViewModelReloadCallbackBlock modelReloadBlock;

- (id)initWithModel:(id)model;

/**
 *  <#Description#>
 *
 *  @param model
 *  @param block callback block to notify the controller that something has changed in the model
 *
 */
- (id)initWithModel:(id)model reloadCallbackBlock:(MBViewModelReloadCallbackBlock)modelReloadCallback;

/**
 * Can be triggered to reload the model. (e.g pull to refresh). The caller is notified with the reload block
 *
 */
-(void) reload;
@end