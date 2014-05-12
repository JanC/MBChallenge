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

@property(nonatomic, strong, readwrite) UITextView *textView;
@property(nonatomic, strong, readwrite) UIBarButtonItem *editButton;
@property(nonatomic, strong, readwrite) UIBarButtonItem *saveButton;
@property(nonatomic, strong, readwrite) UIBarButtonItem *doneButton;
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

    self.saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonTouchedUpInside:)];
    self.editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonTouchedUpInside:)];

    if(self.viewModel.inserting)
    {
        self.navigationItem.rightBarButtonItem = self.saveButton;
    } else {
        self.navigationItem.rightBarButtonItem = self.editButton;
    }


    //
    // Setup TextView
    //
    self.textView = [[UITextView alloc] init];
    self.textView.font = [UIFont MBDefaultTextFont];
    self.textView.dataDetectorTypes = UIDataDetectorTypeAll;
    self.textView.editable = self.viewModel.inserting;
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

    if(self.viewModel.inserting)
    {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        self.textView.editable = NO;
        self.navigationItem.rightBarButtonItem = self.editButton;
    }

}

- (void)editButtonTouchedUpInside:(id)editButtonTouchedUpInside
{
    self.textView.editable = YES;
    self.navigationItem.rightBarButtonItem = self.saveButton;
    [self.textView becomeFirstResponder];
}

@end