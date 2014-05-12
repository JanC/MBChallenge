//
// Created by Jan on 10/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "MBNoteDetailViewController.h"
#import "MBNoteListViewModel.h"
#import "MBNoteDetailViewModel.h"
#import "MBNote.h"
#import "UIFont+MBStyle.h"

@interface MBNoteDetailViewController ()

@property(nonatomic, strong) UITextView *textView;
@end

@implementation MBNoteDetailViewController
{
}

- (void)loadView
{
    [super loadView];

    if ( [self.viewModel shouldShowCancelButton] )
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTouchedUpInside:)];
    }

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonTouchedUpInside:)];

    //
    // Setup TextView
    //
    self.textView = [[UITextView alloc] init];
    self.textView.font = [UIFont MBDefaultTextFont];
    self.textView.dataDetectorTypes = UIDataDetectorTypeAll;
    // self.textView.editable = NO;
    [self.view addSubview:self.textView];

    //
    // Auto Layout
    //
    self.textView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = NSDictionaryOfVariableBindings(_textView);
    NSDictionary *metrics = @{@"spacing" : @10 };
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(spacing)-[_textView]-(spacing)-|" options:0 metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_textView]|" options:0 metrics:metrics views:views]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.textView.text = self.viewModel.model.text;
}

#pragma mark
#pragma mark - Actions

- (void)cancelButtonTouchedUpInside:(id)sender
{
    [self.viewModel cancel];
    [self.viewModel willDismiss];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveButtonTouchedUpInside:(id)sender
{
    self.viewModel.model.text = self.textView.text;
    [self.viewModel willDismiss];

    #warning fix this
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end