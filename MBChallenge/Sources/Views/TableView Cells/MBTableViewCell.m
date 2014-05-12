//
// Created by Jan on 10/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "MBTableViewCell.h"
#import "UIFont+MBStyle.h"
#import "UIColor+MBStyle.h"

@interface MBTableViewCell ()

@property (nonatomic, strong, readwrite) UILabel *noteTitleLabel;

@property (nonatomic, assign, readwrite) BOOL didUpdateConstraints;

@end

@implementation MBTableViewCell
{
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self )
    {

        //
        // Setup Labels
        //
        self.noteTitleLabel = [[UILabel alloc] init];
        self.noteTitleLabel.numberOfLines = 0;

        //
        // Style
        //
        self.noteTitleLabel.font = [UIFont MBDefaultTextFont];
        self.noteTitleLabel.textColor = [UIColor MBDefaultTextColor];




        self.noteTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.noteTitleLabel];
    }

    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];

    if(self.didUpdateConstraints)
    {
        return;
    }

    //
    // Auto Layout
    //

    NSDictionary *views = NSDictionaryOfVariableBindings(_noteTitleLabel);
    NSDictionary *metrics = @{@"verticalSpacing" : @10 };

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_noteTitleLabel]-|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(verticalSpacing)-[_noteTitleLabel]-(verticalSpacing)-|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];

    self.didUpdateConstraints = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];

    // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
    self.noteTitleLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.noteTitleLabel.frame);
}

@end