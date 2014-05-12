//
// Created by Jan on 10/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>
#import "MBNoteListViewController.h"
#import "MBTableViewCell.h"
#import "MBNoteDetailViewController.h"
#import "MBNoteListViewModel.h"
#import "MBTableViewCell+MBNote.h"
#import "NSManagedObjectContext+mainContext.h"
#import "UIColor+MBStyle.h"

#pragma mark - Constants

NSString *const MBNoteListViewControllerCellId = @"MBNoteListViewControllerCellId";
CGFloat const MBNoteListViewControllerCellMaxHeight = 100.0;

@interface MBNoteListViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) MBNoteListViewModel *viewModel;

@property(nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation MBNoteListViewController
{
}

- (instancetype)init
{
    self = [super init];

    if ( self )
    {
        self.title = NSLocalizedString(@"MB Notes", nil);
        self.viewModel = [[MBNoteListViewModel alloc] initWithModel:[NSManagedObjectContext currentContext] reloadCallbackBlock:^(BOOL loading, NSString *loadingMessage) {
            if (loading)
            {
                [SVProgressHUD showWithStatus:NSLocalizedString(@"Loading", @"Loading")];
            }
            else
            {
                [SVProgressHUD dismiss];
            }
            [self.tableView reloadData];
        }];
    }

    return self;
}

- (void)loadView
{
    [super loadView];

    //
    // Setup table view
    //
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[MBTableViewCell class] forCellReuseIdentifier:MBNoteListViewControllerCellId];
    [self.view addSubview:self.tableView];

    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor MBPinkColor];
    [self.refreshControl addTarget:self action:@selector(refreshControlTriggered:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];

    //
    // Navigation Buttons
    //
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(addButtonTouchUpInside:)];

    //
    // Auto Layout
    //
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = NSDictionaryOfVariableBindings(_tableView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:nil views:views]];

    [self.viewModel reload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.viewModel.active = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.viewModel.active = NO;
}

#pragma
#pragma mark - Protocols

#pragma
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.numberOfItems;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MBNoteListViewControllerCellId forIndexPath:indexPath];

    [self configureNoteCell:cell forIndexPath:indexPath];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.viewModel deleteObjectAtIndexPath:indexPath];
    }
}

#pragma
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MBNoteDetailViewController *mbNoteDetailViewController = [[MBNoteDetailViewController alloc] init];
    mbNoteDetailViewController.viewModel = [self.viewModel detailViewModelForIndexPath:indexPath];
    [self.navigationController pushViewController:mbNoteDetailViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MBNoteListViewControllerCellId];

    [self configureNoteCell:cell forIndexPath:indexPath];

    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];

    // Set the width of the cell to match the width of the table view. This is important so that we'll get the
    // correct cell height for different table view widths if the cell's height depends on its width (due to
    // multi-line UILabels word wrapping, etc). We don't need to do this above in -[tableView:cellForRowAtIndexPath]
    // because it happens automatically when the cell is used in the table view.
    // Also note, the final width of the cell may not be the width of the table view in some cases, for example when a
    // section index is displayed along the right side of the table view. You must account for the reduced cell width.
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));

    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints.
    // (Note that you must set the preferredMaxLayoutWidth on multi-line UILabels inside the -[layoutSubviews] method
    // of the UITableViewCell subclass, or do it manually at this point before the below 2 lines!)
    [cell setNeedsLayout];
    [cell layoutIfNeeded];

    // Get the actual height required for the cell's contentView
    height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;

    // Add an extra point to the height to account for the cell separator, which is added between the bottom
    // of the cell's contentView and the bottom of the table view cell.
    height += 1.0f;

//    if(height > MBNoteListViewControllerCellMaxHeight) {
//        height = MBNoteListViewControllerCellMaxHeight;
//    }

    return height;
}

#pragma mark
#pragma mark - Actions

- (void)addButtonTouchUpInside:(id)addButtonTouchUpInside
{
    MBNoteDetailViewController *mbNoteDetailViewController = [[MBNoteDetailViewController alloc] init];

    mbNoteDetailViewController.viewModel = [self.viewModel detailViewModelForNewItem];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mbNoteDetailViewController];

    [self.navigationController presentViewController:navigationController animated:YES completion:^{

    }];
}

- (void)refreshControlTriggered:(id)sender
{
    [self.refreshControl endRefreshing]; // the "refreshing" state is showed by the HUD
    [self.viewModel reload];
}
#pragma mark
#pragma mark - Private

- (void)configureNoteCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    NSAssert([cell isKindOfClass:[MBTableViewCell class]], @"%@ expects cells of type %@", NSStringFromSelector(@selector(configureNoteCell:forIndexPath:)), NSStringFromClass([MBTableViewCell class]));

    MBTableViewCell *mbTableViewCell = (MBTableViewCell *)cell;
    [mbTableViewCell configureForMBNote:[self.viewModel itemAtIndexPath:indexPath]];

}

@end